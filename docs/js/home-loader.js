// Inject docs/landing.html content into the MkDocs homepage so we keep the global header.
(async function injectLanding() {
  try {
    const host = document.querySelector("#landing-host");
    if (!host) return;
    const res = await fetch(new URL("./landing.html", window.location.href));
    const html = await res.text();
    // Extract body inner to avoid duplicate <html> structures
    const tmp = document.createElement("html");
    tmp.innerHTML = html;
    const body = tmp.querySelector("body");
    host.innerHTML = body ? body.innerHTML : html;
  } catch (e) {
    console.error("Failed loading landing.html", e);
  }
})();
