import { NextResponse } from 'next/server';

function extractDataCenter(serverPrefix, apiKey) {
  // Prefer explicit env if present and valid (just data center like "us15")
  if (serverPrefix) {
    const trimmed = serverPrefix.trim();
    // If someone pasted a full URL (e.g. https://us15.admin.mailchimp.com), try to extract the subdomain
    if (/^https?:\/\//i.test(trimmed)) {
      try {
        const url = new URL(trimmed);
        const sub = url.hostname.split('.')[0]; // us15
        if (sub) return sub;
      } catch {
        // fall through to other heuristics
      }
    }
    // If value already looks like a dc token (usX), use it
    const dcMatch = trimmed.match(/^[a-z]{2}\d{1,2}$/i);
    if (dcMatch) return trimmed;
    // Try to pick a token that looks like us15 inside the string
    const tokenMatch = trimmed.match(/([a-z]{2}\d{1,2})/i);
    if (tokenMatch) return tokenMatch[1];
  }

  // Fallback: derive from API key suffix (e.g., key-us15)
  if (apiKey && apiKey.includes('-')) {
    const parts = apiKey.split('-');
    const dc = parts[parts.length - 1];
    if (/^[a-z]{2}\d{1,2}$/i.test(dc)) return dc;
  }

  return null; // Unable to determine
}

export async function POST(request) {
  try {
    const body = await request.json().catch(() => ({}));
    const email = body?.email?.toString().trim();
    const firstName = body?.firstName?.toString().trim() || '';
    const lastName = body?.lastName?.toString().trim() || '';

    if (!email) {
      return NextResponse.json({ error: 'Email is required' }, { status: 400 });
    }

    // Simple email format check
    const emailRegex = /\S+@\S+\.\S+/;
    if (!emailRegex.test(email)) {
      return NextResponse.json({ error: 'Invalid email format' }, { status: 400 });
    }

    // Environment variables
    const API_KEY = process.env.MAILCHIMP_API_KEY;
    const AUDIENCE_ID = process.env.MAILCHIMP_AUDIENCE_ID;
    const SERVER_PREFIX_RAW = process.env.MAILCHIMP_API_SERVER;

    if (!API_KEY) {
      return NextResponse.json({ error: 'Server is misconfigured: missing API key.' }, { status: 500 });
    }
    if (!AUDIENCE_ID) {
      return NextResponse.json({ error: 'Server is misconfigured: missing audience/list ID.' }, { status: 500 });
    }

    const dataCenter = extractDataCenter(SERVER_PREFIX_RAW, API_KEY);
    if (!dataCenter) {
      return NextResponse.json({ error: 'Server is misconfigured: unable to determine Mailchimp data center.' }, { status: 500 });
    }

    const API_URL = `https://${dataCenter}.api.mailchimp.com/3.0/lists/${AUDIENCE_ID}/members`;

    const DOUBLE_OPT_IN = String(process.env.MAILCHIMP_DOUBLE_OPT_IN || '').toLowerCase() === 'true';

    const payload = {
      email_address: email,
      status: DOUBLE_OPT_IN ? 'pending' : 'subscribed',
      merge_fields: {
        FNAME: firstName,
        LNAME: lastName,
      },
    };

    const mcRes = await fetch(API_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Basic ${Buffer.from(`anystring:${API_KEY}`).toString('base64')}`,
      },
      body: JSON.stringify(payload),
    });

  if (!mcRes.ok) {
      let errorData = null;
      try {
        errorData = await mcRes.json();
      } catch {
        // swallow JSON parse errors
      }

      // Treat "Member Exists" as success from UX perspective
      const title = errorData?.title || '';
      if (mcRes.status === 400 && /member exists/i.test(title)) {
        // Upsert names for existing member
        try {
          const crypto = await import('crypto');
          const hash = crypto.createHash('md5').update(email.toLowerCase()).digest('hex');
          const putUrl = `https://${dataCenter}.api.mailchimp.com/3.0/lists/${AUDIENCE_ID}/members/${hash}`;
          const upsertPayload = {
            email_address: email,
            status_if_new: DOUBLE_OPT_IN ? 'pending' : 'subscribed',
            merge_fields: {
              FNAME: firstName,
              LNAME: lastName,
            },
          };
          const putRes = await fetch(putUrl, {
            method: 'PUT',
            headers: {
              'Content-Type': 'application/json',
              Authorization: `Basic ${Buffer.from(`anystring:${API_KEY}`).toString('base64')}`,
            },
            body: JSON.stringify(upsertPayload),
          });

          if (putRes.ok) {
            const msg = DOUBLE_OPT_IN
              ? 'You are on our list. If you haven\'t confirmed before, please check your email to confirm.'
              : 'You are already subscribed. Details updated.';
            return NextResponse.json({ message: msg }, { status: 200 });
          }
        } catch (e) {
          // Non-fatal; fall back to success message
        }
        return NextResponse.json({ message: DOUBLE_OPT_IN ? 'You are already on our list.' : 'You are already subscribed.' }, { status: 200 });
      }

      const message = title || 'There was an error subscribing to the newsletter.';
      return NextResponse.json({ error: message }, { status: 400 });
    }

    if (DOUBLE_OPT_IN) {
      return NextResponse.json(
        { message: 'Please check your email to confirm your subscription.' },
        { status: 202 },
      );
    }
    return NextResponse.json({ message: 'Success! You are now subscribed.' }, { status: 201 });
  } catch (err) {
    console.error('Subscribe API error:', err);
    // Common network error: fetch failed (e.g., wrong API base URL / data center)
    return NextResponse.json({ error: err?.message || 'Internal Server Error' }, { status: 500 });
  }
}