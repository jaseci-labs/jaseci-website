---
title: Array Methods
description: Using array methods to render lists in JAC-Client.
---

---

## map

Transform each element in an array.

```javascript tab="JavaScript"
const doubled = numbers.map((n) => n * 2);
```

```python tab="JAC-Client"
# Use helper function (recommended)
def double(n: int, index: int) -> int {
    return n * 2;
}
doubled = numbers.map(double);

# Or inline lambda
doubled = numbers.map(lambda n: int, i: int -> int { return n * 2; });
```

**Note:** Callback receives `(item, index)`.

---

## filter

Keep only elements that match a condition.

```javascript tab="JavaScript"
const evens = numbers.filter((n) => n % 2 === 0);
```

```python tab="JAC-Client"
evens = numbers.filter(lambda n: int -> bool { return n % 2 == 0; });

# With helper function
def isEven(n: int) -> bool {
    return n % 2 == 0;
}
evens = numbers.filter(isEven);
```

---

## find

Find the first element that matches.

```javascript tab="JavaScript"
const user = users.find((u) => u.id === targetId);
```

```python tab="JAC-Client"
user = users.find(lambda u: dict -> bool { return u["id"] == targetId; });
```

---

## some

Check if any element matches.

```javascript tab="JavaScript"
const hasAdmin = users.some((u) => u.role === "admin");
```

```python tab="JAC-Client"
hasAdmin = users.some(lambda u: dict -> bool { return u["role"] == "admin"; });
```

---

## every

Check if all elements match.

```javascript tab="JavaScript"
const allActive = users.every((u) => u.active);
```

```python tab="JAC-Client"
allActive = users.every(lambda u: dict -> bool { return u["active"]; });
```

---

## reduce

Reduce array to a single value.

```javascript tab="JavaScript"
const sum = numbers.reduce((acc, n) => acc + n, 0);
```

```python tab="JAC-Client"
sum = numbers.reduce(
    lambda acc: int, n: int -> int { return acc + n; },
    0
);
```

---

## Practical Examples

### Transform Objects

```python
users = [
    { "id": 1, "name": "Alice", "email": "alice@example.com" },
    { "id": 2, "name": "Bob", "email": "bob@example.com" }
];

# Extract names
def getName(user: dict, index: int) -> str {
    return user["name"];
}
names = users.map(getName);
# ["Alice", "Bob"]

# Create select options
def toOption(user: dict, index: int) -> dict {
    return { "value": user["id"], "label": user["name"] };
}
options = users.map(toOption);
```

### Filter by Multiple Conditions

```python
products = [
    { "name": "Laptop", "price": 999, "inStock": True },
    { "name": "Phone", "price": 699, "inStock": True },
    { "name": "Tablet", "price": 499, "inStock": False },
    { "name": "Watch", "price": 299, "inStock": True }
];

# Affordable AND in stock
affordable = products.filter(lambda p: dict -> bool {
    return p["price"] < 500 and p["inStock"];
});
```

### Chain Methods

```python
users = [
    { "name": "Alice", "age": 25, "active": True },
    { "name": "Bob", "age": 17, "active": True },
    { "name": "Charlie", "age": 30, "active": False },
    { "name": "Diana", "age": 22, "active": True }
];

# Get names of active adults
activeAdults = users
    .filter(lambda u: dict -> bool { return u["active"]; })
    .filter(lambda u: dict -> bool { return u["age"] >= 18; })
    .map(lambda u: dict, i: int -> str { return u["name"]; });
# ["Alice", "Diana"]
```

### Calculate Totals

```python
cart = [
    { "name": "Apple", "price": 1.50, "quantity": 3 },
    { "name": "Banana", "price": 0.75, "quantity": 5 },
    { "name": "Orange", "price": 2.00, "quantity": 2 }
];

total = cart.reduce(
    lambda acc: float, item: dict -> float {
        return acc + (item["price"] * item["quantity"]);
    },
    0
);
# total = 12.25
```

### Group By

```python
items = [
    { "type": "fruit", "name": "Apple" },
    { "type": "vegetable", "name": "Carrot" },
    { "type": "fruit", "name": "Banana" },
    { "type": "vegetable", "name": "Broccoli" }
];

grouped = items.reduce(
    lambda acc: dict, item: dict -> dict {
        itemType = item["type"];
        if acc[itemType] == None {
            acc[itemType] = [];
        }
        acc[itemType].push(item);
        return acc;
    },
    {}
);
# { "fruit": [...], "vegetable": [...] }
```

---

## Other Methods

### concat

```python
arr1 = [1, 2, 3];
arr2 = [4, 5, 6];
combined = arr1.concat(arr2);  # [1, 2, 3, 4, 5, 6]
```

### slice

```python
arr = [0, 1, 2, 3, 4, 5];
portion = arr.slice(1, 4);  # [1, 2, 3]
last3 = arr.slice(-3);      # [3, 4, 5]
```

### indexOf

```python
arr = ["a", "b", "c", "d"];
index = arr.indexOf("c");  # 2
notFound = arr.indexOf("z");  # -1
```

### includes

```python
arr = [1, 2, 3, 4, 5];
has3 = arr.includes(3);  # True
has9 = arr.includes(9);  # False
```

### join

```python
arr = ["a", "b", "c"];
str = arr.join(", ");  # "a, b, c"
str = arr.join("-");   # "a-b-c"
```

### reverse

```python
arr = [1, 2, 3];
reversed = arr.reverse();  # [3, 2, 1]
```

### sort

```python
arr = [3, 1, 4, 1, 5, 9, 2, 6];
sorted = arr.sort();  # [1, 1, 2, 3, 4, 5, 6, 9]

# Custom sort
def compare(a: int, b: int) -> int {
    return b - a;  # Descending
}
sorted = arr.sort(compare);
```

---

## Summary

| Method | Purpose       | Callback                   |
| ------ | ------------- | -------------------------- |
| map    | Transform     | `(item, index) -> newItem` |
| filter | Keep matching | `(item) -> bool`           |
| find   | First match   | `(item) -> bool`           |
| some   | Any match     | `(item) -> bool`           |
| every  | All match     | `(item) -> bool`           |
| reduce | Accumulate    | `(acc, item) -> newAcc`    |
