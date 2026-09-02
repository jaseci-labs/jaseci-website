"""`any`-typed handles onto the browser DOM.

`jac check` has no typed stubs for the DOM yet, so every direct
`document.*` / `window.*` member access errors out. Funnelling those
accesses through this module keeps the untyped boundary in one place.
"""

def:pub doc() -> any {
    return document;
}

def:pub win() -> any {
    return window;
}

def:pub head() -> any {
    return document.head;
}

def:pub body() -> any {
    return document.body;
}

def:pub query(selector: str) -> any {
    return document.querySelector(selector);
}

def:pub by_id(element_id: str) -> any {
    return document.getElementById(element_id);
}

def:pub create(tag: str) -> any {
    return document.createElement(tag);
}
