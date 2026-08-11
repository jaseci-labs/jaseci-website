# Working in this Jac project

This is the Jac port of `jaseci.org`. Jac's syntax is easily confused with
Python or JSX — consult the reference guides bundled with the compiler before
writing or editing `.jac` files.

## Reference guides

- `jac guide` — list every available guide
- `jac guide <name>` — print a guide (e.g. `jac guide jac-cl-components`)
- `jac guide --search <keyword>` — find guides by topic

Start with `jac guide jac-core-cheatsheet`, then `jac-cl-components`,
`jac-cl-routing` and `jac-fullstack-patterns` for the UI side.

## Validate your work

- `jac check .` — type-check and lint the whole project
- `jac start --dev` — dev server with HMR (kill stale servers first:
  `pkill -f "jac start"`, otherwise the port drifts and RPC proxying breaks)
- `jac browse open localhost:<port>` → `snapshot` / `click @e5` / `console` /
  `screenshot` / `close` — QA the running app

## Project-specific gotchas

These cost real debugging time on this codebase; check them first.

1. **`match` statements are dropped in client code.** A client `def` whose body
   is a `match` compiles to an empty function — no error, no warning, the UI
   just renders nothing where the call was. Use `if` / `return` chains instead
   (see `icon_for` in `components/Social.cl.jac`).
2. **Client modules that `sv import` must use the explicit `.cl.jac`
   extension.** With inferred placement, `jac start` reads the `sv import` as a
   server-to-server boundary, auto-detects microservice mode, and runs
   `server/content.jac` as a separate process behind a gateway.
3. **`glob` and `obj` need `:pub` to cross client module boundaries.** Without
   it they are simply not emitted as JS exports, and the browser fails at load
   with `does not provide an export named 'X'`. `jac check` does not catch this.
4. **No Python stdlib in client code.** `import re;` in a `.cl.jac` file
   type-checks fine and then fails the Vite build with
   `Failed to resolve import "re"`. Write the logic with string operations.
5. **Browser globals go through `lib/dom.cl.jac`.** `jac check` has no DOM type
   stubs, so `document.createElement(...).id = x` fails with E1030.
6. **Elements inside a `{if ...}` slot need a `key`.** The compiler lowers
   conditional slots to arrays, so React warns about missing keys otherwise.
7. **`new(URLSearchParams, ...)` trips E1053** — a known false positive,
   suppressed inline with `# jac:ignore[E1053]`.

## Layout

See `README.md` for the directory map, the route table, and how each Next.js
file maps onto its Jac counterpart.
