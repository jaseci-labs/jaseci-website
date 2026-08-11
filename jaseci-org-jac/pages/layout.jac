"""Root layout - the Next.js `app/layout.js` shell (top bar, header, footer)."""

import from "@jac/runtime" { Outlet, useLocation }
import from ..components.Header { Header }
import from ..components.Footer { Footer }
import from ..components.Analytics { Analytics }
import from ..lib.dom { win }

def:pub Shell() -> JsxLayout {
    location = useLocation();

    can with [location.pathname] entry {
        win().scroll(0, 0);
    }

    return <div>
        <Analytics />
        <Header />
        <main className="">
            <Outlet />
        </main>
        <Footer />
    </div>;
}
