"""Search overlay - ports `layouts/partials/SearchModal.js`."""

import from react { useEffect }
import from "@jac/runtime" { useNavigate }
import from "react-icons/io5" { IoCloseCircleOutline }
import from ..lib.dom { body, by_id, doc }

def:pub SearchModal(open: bool, onClose: Callable[[], None]) -> JsxElement {
    has input: str = "";

    nav = useNavigate();

    useEffect(lambda {
        if not open {
            return lambda { };
        }
        box = by_id("searchModal");
        if box {
            box.focus();
        }
        previous_overflow = body().style.overflow;
        body().style.overflow = "hidden";

        on_key = lambda (e: KeyboardEvent) {
            if e.key == "Enter" {
                nav("/search?key=" + encodeURIComponent(input));
                onClose();
            }
            if e.key == "Escape" {
                onClose();
            }
        };
        doc().addEventListener("keydown", on_key);
        return lambda {
            doc().removeEventListener("keydown", on_key);
            body().style.overflow = previous_overflow;
        };
    }, [open, input]);

    def handle_change(e: ChangeEvent) {
        input = e.target.value;
    }

    def handle_backdrop(e: MouseEvent) {
        onClose();
    }

    def stop(e: MouseEvent) {
        e.stopPropagation();
    }

    def handle_close(e: MouseEvent) {
        onClose();
    }

    return <div
        role="dialog"
        aria-modal="true"
        aria-label="Search"
        className={"search-modal open" if open else "search-modal"}
        onClick={handle_backdrop}
    >
        <div className="search-box" onClick={stop}>
            <button
                aria-label="Close search"
                onClick={handle_close}
                className="search-close"
            >
                <IoCloseCircleOutline />
            </button>
            <input
                type="text"
                className="form-input"
                id="searchModal"
                placeholder="Search posts, tags, authors…"
                onChange={handle_change}
                autoComplete="off"
            />
        </div>
    </div>;
}
