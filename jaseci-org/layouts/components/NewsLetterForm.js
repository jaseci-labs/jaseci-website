'use client'; // Required for App Router to use hooks

import { useEffect, useState } from 'react';

export default function NewsletterForm() {
  const [formData, setFormData] = useState({
    email: '',
    firstName: '',
    lastName: '',
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isSuccess, setIsSuccess] = useState(false);
  const [errorMsg, setErrorMsg] = useState('');
  const [isSubmitDisabled, setIsSubmitDisabled] = useState(true);

  const isValidEmail = (email) => /\S+@\S+\.\S+/.test(email);

  useEffect(() => {
    setIsSubmitDisabled(!isValidEmail(formData.email));
  }, [formData.email]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    if (isSubmitting || isSubmitDisabled) return;
    setIsSubmitting(true);
    setIsSuccess(false);
    setErrorMsg('');

    try {
      const res = await fetch('/api/subscribe', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          email: formData.email,
          firstName: formData.firstName,
          lastName: formData.lastName,
        }),
      });

      const data = await res.json().catch(() => ({}));

      if (!res.ok) {
        throw new Error(data?.error || 'Subscription failed.');
      }

      setIsSuccess(true);
      setFormData({ email: '', firstName: '', lastName: '' });
      setTimeout(() => setIsSuccess(false), 3000);
    } catch (err) {
      setErrorMsg(err?.message || 'Something went wrong.');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <section className="py-20">
      <div className="container max-w-3xl mx-auto px-5">
        <div className="border-2 border-primary-orange/20 rounded-2xl shadow-2xl shadow-primary-orange/10 p-6 md:p-8">
          <h2 className="text-center text-3xl font-extrabold mb-4">Subscribe to Our Newsletter</h2>
          <p className="text-center text-community-text bg-primary-orange/10 border border-primary-orange/30 rounded-lg p-4 mb-6">
            Get the latest project updates, deep dives into new features, and community highlights delivered directly to your inbox.
          </p>

          {isSuccess ? (
            <div className="text-center text-green-400 font-semibold p-4 bg-green-500/10 rounded-lg" role="status">
              You&apos;re subscribed! 🎉
            </div>
          ) : (
            <form onSubmit={handleSubmit} className="grid gap-4" noValidate>
              <div className="grid gap-2">
                <label className="font-semibold" htmlFor="subscribe-email">Email *</label>
                <input
                  className="w-full rounded-md border-community-border bg-[#0f0f11] text-white p-3 focus:border-community-primary focus:ring-2 focus:ring-community-primary/50"
                  id="subscribe-email"
                  name="email"
                  type="email"
                  placeholder="Enter your email"
                  required
                  value={formData.email}
                  onChange={handleChange}
                />
              </div>
              <div className="grid md:grid-cols-2 gap-4">
                <div className="grid gap-2">
                  <label className="font-semibold" htmlFor="subscribe-first-name">First name</label>
                  <input
                    className="w-full rounded-md border-community-border bg-[#0f0f11] text-white p-3 focus:border-community-primary focus:ring-2 focus:ring-community-primary/50"
                    id="subscribe-first-name"
                    name="firstName"
                    type="text"
                    placeholder="Enter first name"
                    value={formData.firstName}
                    onChange={handleChange}
                  />
                </div>
                <div className="grid gap-2">
                  <label className="font-semibold" htmlFor="subscribe-last-name">Last name</label>
                  <input
                    className="w-full rounded-md border-community-border bg-[#0f0f11] text-white p-3 focus:border-community-primary focus:ring-2 focus:ring-community-primary/50"
                    id="subscribe-last-name"
                    name="lastName"
                    type="text"
                    placeholder="Enter last name"
                    value={formData.lastName}
                    onChange={handleChange}
                  />
                </div>
              </div>

              <button
                className="w-full inline-flex items-center justify-center gap-2 font-semibold text-lg px-5 py-3 rounded-lg border-2 border-community-primary bg-community-primary text-black transition-all duration-300 hover:bg-primary-orange/80 hover:border-primary-orange/80 disabled:opacity-50 disabled:cursor-not-allowed"
                type="submit"
                disabled={isSubmitDisabled || isSubmitting}
              >
                {isSubmitting ? 'Submitting...' : 'Subscribe'}
              </button>

              {errorMsg && (
                <p className="text-center text-sm text-red-400" role="alert">{errorMsg}</p>
              )}

              <p className="text-center text-sm text-community-muted">We respect your privacy. Unsubscribe anytime.</p>
            </form>
          )}
        </div>
      </div>
    </section>
  );
}