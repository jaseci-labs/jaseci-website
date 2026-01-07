---
title: What is JAC-Client?
description: JAC-Client is a frontend programming language that combines Python-like syntax with React's component model. It compiles to JavaScript and React, giving you the best of both worlds.
---

---

## Why JAC-Client?

| Feature                | Benefit                                                |
| ---------------------- | ------------------------------------------------------ |
| **Python-like syntax** | Familiar to Python developers, cleaner than JavaScript |
| **React compatible**   | Uses JSX, hooks, and React ecosystem                   |
| **Type annotations**   | Optional type hints for better code quality            |
| **No boilerplate**     | No `const`, `let`, `function` keywords needed          |

---

## JAC-Client vs JavaScript

### Cleaner Syntax

```javascript tab="JavaScript"
const name = "John";
let count = 0;
const isActive = true;
const data = null;
```

```python tab="JAC-Client"
name = "John"
count = 0
isActive = True
data = None
```

### Functions

```javascript tab="JavaScript"
function greet(name) {
  return `Hello, ${name}!`;
}

const double = (x) => x * 2;
```

```python tab="JAC-Client"
def greet(name: str) -> str {
    return "Hello, " + name + "!";
}

double = lambda x: int -> int { return x * 2; }
```

### React Components

```jsx tab="JavaScript/React"
function Counter() {
  const [count, setCount] = useState(0);

  return <button onClick={() => setCount(count + 1)}>Count: {count}</button>;
}
```

```python tab="JAC-Client"
def Counter() -> any {
    [count, setCount] = useState(0);

    return (
        <button onClick={lambda: setCount(count + 1)}>
            Count: {count}
        </button>
    );
}
```

---

## Core Concepts

### 1. The `cl` Block

All client-side (frontend) code must be wrapped in a `cl { }` block:

```python
cl {
    def app() -> any {
        return <h1>Hello!</h1>;
    }
}
```

### 2. The `app()` Entry Point

Every JAC-Client project needs an `app.jac` file with a `def app()` function:

```python
cl {
    def app() -> any {
        return <div>Your app here</div>;
    }
}
```

### 3. Imports

Import npm packages and other files using `cl import`:

```python
# Import from npm packages
cl import from react { useState, useEffect }
cl import from react-router-dom { Link, useNavigate }

# Import from local files
cl import from ./components { Header, Footer }
```

### 4. Lambda Functions

Arrow functions in JavaScript become lambdas in JAC:

```python
# No parameters
onClick={lambda: doSomething()}

# With parameters
onChange={lambda e: any -> None { setName(e.target.value); }}

# With return value
doubled = numbers.map(lambda n: int, i: int -> int { return n * 2; })
```

---

## What Makes JAC Different

### Python-Style Conditionals

```javascript tab="JavaScript"
isLoggedIn ? <Dashboard /> : <Login />;
```

```python tab="JAC-Client"
(<Dashboard />) if isLoggedIn else (<Login />)
```

### No `let` or `const`

Just assign directly:

```python
name = "John"
[count, setCount] = useState(0)
items = [1, 2, 3]
```

### Quoted Object Keys

Object keys must be strings:

```python
# JAC-Client
user = { "name": "John", "age": 25 }
style = { "padding": "10px", "margin": "5px" }
```

### Property Access

Use bracket notation:

```python
name = user["name"]
value = props["value"]
```

---

## When to Use JAC-Client

**Good for:**

- Building React-style web applications
- Teams familiar with Python syntax
- Projects that benefit from optional typing
- Rapid prototyping with cleaner syntax

**JAC-Client ecosystem:**

- Full React hooks support
- React Router integration
- State management (Zustand, Redux)
- Form libraries (React Hook Form)
- Styling (Tailwind, styled-components)
