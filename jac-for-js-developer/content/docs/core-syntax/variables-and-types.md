---
title: Variables and Types
description: Learn about variables and types in JAC-Client.
---


---

## Variables - No `let` or `const`

In JAC-Client, you don't need `let`, `const`, or `var`. Just assign directly:

```javascript tab="JavaScript"
const name = "John";
let count = 0;
const isActive = true;
var legacy = "old";
```

```python tab="JAC-Client"
name = "John"
count = 0
isActive = True
legacy = "old"
```

### State Variables

Same pattern for React state:

```javascript tab="JavaScript"
const [count, setCount] = useState(0);
const [name, setName] = useState("");
const [items, setItems] = useState([]);
```

```python tab="JAC-Client"
[count, setCount] = useState(0);
[name, setName] = useState("");
[items, setItems] = useState([]);
```

---

## Data Types

### Booleans - Capitalized!

```javascript tab="JavaScript"
const isActive = true;
const isHidden = false;
```

```python tab="JAC-Client"
isActive = True
isHidden = False
```

### Null - Use `None`

```javascript tab="JavaScript"
const data = null;
const user = undefined;
```

```python tab="JAC-Client"
data = None
user = None  # undefined is also None
```

### Checking for None

```python
if data == None {
    console.log("No data");
}

# Or
if data != None {
    console.log("Has data");
}
```

---

## Type Annotations

JAC-Client supports optional type annotations:

```python
# Basic types
name: str = "John"
age: int = 25
price: float = 19.99
isActive: bool = True

# Complex types
items: list = [1, 2, 3]
user: dict = { "name": "John", "age": 25 }

# Any type (flexible)
data: any = someValue
```

### Common Types

| Type    | Description       | Example              |
| ------- | ----------------- | -------------------- |
| `str`   | String            | `"hello"`            |
| `int`   | Integer           | `42`                 |
| `float` | Decimal           | `3.14`               |
| `bool`  | Boolean           | `True`, `False`      |
| `list`  | Array             | `[1, 2, 3]`          |
| `dict`  | Object/Dictionary | `{ "key": "value" }` |
| `any`   | Any type          | Flexible             |
| `None`  | No type/null      | `None`               |

---

## Objects/Dictionaries

### Key Difference: Quoted Keys

In JAC-Client, object keys **must be quoted strings**:

```javascript tab="JavaScript"
const user = { name: "John", age: 25 };
const style = { padding: "10px", margin: "5px" };
```

```python tab="JAC-Client"
user = { "name": "John", "age": 25 }
style = { "padding": "10px", "margin": "5px" }
```

### Property Access - Bracket Notation

Use bracket notation to access properties:

```javascript tab="JavaScript"
const name = user.name;
const age = user.age;
```

```python tab="JAC-Client"
name = user["name"]
age = user["age"]
```

**Note:** Dot notation (`user.name`) may work but bracket notation is recommended.

### Nested Objects

```python
user = {
    "name": "John",
    "address": {
        "city": "New York",
        "zip": "10001"
    },
    "tags": ["developer", "designer"]
}

# Access nested properties
city = user["address"]["city"]
firstTag = user["tags"][0]
```

---

## Arrays

Arrays work similarly to JavaScript:

```python
# Create arrays
numbers = [1, 2, 3, 4, 5]
names = ["Alice", "Bob", "Charlie"]
mixed = [1, "two", True, None]

# Access elements
first = numbers[0]
last = numbers[numbers.length - 1]

# Array methods
numbers.push(6)
removed = numbers.pop()
combined = numbers.concat([7, 8, 9])
```

### No Spread Operator for Arrays

```javascript tab="JavaScript"
const newArr = [...arr, 4, 5];
```

```python tab="JAC-Client"
newArr = arr.concat([4, 5])
```

### Object Spread Uses `**`

```javascript tab="JavaScript"
const newObj = { ...obj, newKey: "value" };
```

```python tab="JAC-Client"
newObj = { **obj, "newKey": "value" }
```

---

## String Interpolation

JAC-Client uses string concatenation:

```javascript tab="JavaScript"
const message = `Hello, ${name}! You are ${age} years old.`;
```

```python tab="JAC-Client"
message = "Hello, " + name + "! You are " + age.toString() + " years old."
```

---

## Constants (Global Variables)

Use `glob` for global constants:

```python
cl {
    glob API_URL: str = "https://api.example.com"
    glob MAX_ITEMS: int = 100
    glob DEBUG: bool = False

    def app() -> any {
        console.log(API_URL);
        return <div>App</div>;
    }
}
```

### Exporting Constants

Use `glob:pub` to export:

```python
glob:pub API_URL: str = "https://api.example.com"
glob:pub MAX_ITEMS: int = 100
```

---

## Type Coercion

```python
# String to number
numStr = "42"
num = parseInt(numStr)  # 42

# Number to string
age = 25
ageStr = age.toString()  # "25"

# Boolean coercion
if items.length {  # truthy if length > 0
    console.log("Has items");
}
```

---

## Summary

| Concept              | JavaScript     | JAC-Client        |
| -------------------- | -------------- | ----------------- |
| Variable declaration | `const x = 5`  | `x = 5`           |
| Boolean true         | `true`         | `True`            |
| Boolean false        | `false`        | `False`           |
| Null                 | `null`         | `None`            |
| Object creation      | `{ key: val }` | `{ "key": val }`  |
| Property access      | `obj.key`      | `obj["key"]`      |
| Object spread        | `{...obj}`     | `{**obj}`         |
| Array spread         | `[...arr]`     | `arr.concat([])`  |
| Template string      | `` `${var}` `` | `"" + var`        |
| Type annotation      | TypeScript     | `name: str = "x"` |
