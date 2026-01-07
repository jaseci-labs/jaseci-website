---
title: Ternary
description: Using ternary operators for conditional rendering in JAC-Client.
---

---

## Syntax Comparison

```javascript tab="JavaScript"
condition ? valueIfTrue : valueIfFalse;
```

```python tab="JAC-Client"
(valueIfTrue) if condition else (valueIfFalse)
```

**Note:** Parentheses around values are recommended, especially with JSX.

---

## Basic Examples

### Text Values

```python
# JavaScript: isActive ? "Active" : "Inactive"
status = ("Active") if isActive else ("Inactive")

# JavaScript: count > 0 ? "Has items" : "Empty"
message = ("Has items") if count > 0 else ("Empty")
```

### In JSX

```python
def StatusBadge(props: dict) -> any {
    return (
        <span>
            {("Online") if props["isOnline"] else ("Offline")}
        </span>
    );
}
```

---

## JSX Components in Ternary

**Important:** Wrap JSX components in parentheses!

```python
def AuthContent(props: dict) -> any {
    return (
        <div>
            {(<Dashboard />) if props["isLoggedIn"] else (<LoginForm />)}
        </div>
    );
}
```

### More Examples

```python
# Show different components
{(<AdminPanel />) if isAdmin else (<UserPanel />)}

# Show or hide content
{(<Details data={item} />) if showDetails else (<Summary data={item} />)}

# Loading state
{(<Spinner />) if loading else (<Content data={data} />)}
```

---

## Nested Ternary

For multiple conditions (use sparingly - can be hard to read):

```python
# JavaScript: score >= 90 ? "A" : score >= 80 ? "B" : "C"
grade = ("A") if score >= 90 else (("B") if score >= 80 else ("C"))

# More readable with line breaks
grade = ("A") if score >= 90 else (
    ("B") if score >= 80 else (
        ("C") if score >= 70 else ("F")
    )
)
```

---

## Dynamic Styles

```python
def Button(props: dict) -> any {
    bgColor = ("#28a745") if props["primary"] else ("#6c757d");
    textColor = ("white") if props["primary"] else ("#333");

    return (
        <button style={{
            "backgroundColor": bgColor,
            "color": textColor,
            "padding": "10px 20px",
            "border": "none",
            "borderRadius": "5px"
        }}>
            {props["label"]}
        </button>
    );
}

# Complex style
def Card(props: dict) -> any {
    return (
        <div style={{
            "border": ("2px solid red") if props["hasError"] else ("1px solid #ccc"),
            "backgroundColor": ("#fff0f0") if props["hasError"] else ("white"),
            "opacity": ("0.5") if props["disabled"] else ("1")
        }}>
            {props["children"]}
        </div>
    );
}
```

---

## Dynamic Classes

```python
def Tab(props: dict) -> any {
    className = ("tab active") if props["isActive"] else ("tab");

    return <div className={className}>{props["label"]}</div>;
}

# Multiple conditions
def Button(props: dict) -> any {
    size = ("btn-lg") if props["large"] else (("btn-sm") if props["small"] else ("btn-md"));
    variant = ("btn-primary") if props["primary"] else ("btn-secondary");
    className = "btn " + size + " " + variant;

    return <button className={className}>{props["label"]}</button>;
}
```

---

## Dynamic Attributes

```python
def Input(props: dict) -> any {
    return (
        <input
            type={("password") if props["secure"] else ("text")}
            placeholder={("Enter password") if props["secure"] else ("Enter text")}
            disabled={props["disabled"]}
        />
    );
}
```

---

## Ternary vs If/Else

### Use Ternary For

- Simple either/or values
- Inline in JSX
- Toggle between two options

```python
# Good for ternary
<p>{("Yes") if isActive else ("No")}</p>
<div className={("open") if isOpen else ("closed")} />
```

### Use If/Else For

- Multiple conditions
- Complex logic
- Early returns

```python
# Better as if/else
def StatusIcon(props: dict) -> any {
    if props["status"] == "success" {
        return <GreenCheck />;
    } elif props["status"] == "warning" {
        return <YellowWarning />;
    } elif props["status"] == "error" {
        return <RedX />;
    }
    return <GrayDash />;
}
```

---

## Common Patterns

### Button Text

```python
<button>
    {("Loading...") if isLoading else ("Submit")}
</button>
```

### Show/Hide Element

```python
{(content) if isVisible else (<></>)}

# Or just use AND (see next section)
{isVisible and content}
```

### Default Values

```python
<p>{(props["name"]) if props["name"] else ("Anonymous")}</p>

# Or use 'or' for truthy check
<p>{props["name"] or "Anonymous"}</p>
```

### Toggle Icon

```python
<span>
    {("▼") if isExpanded else ("▶")}
</span>
```

---

## Summary

| JavaScript          | JAC-Client                  |
| ------------------- | --------------------------- |
| `a ? b : c`         | `(b) if a else (c)`         |
| `x ? "yes" : "no"`  | `("yes") if x else ("no")`  |
| `x ? <A /> : <B />` | `(<A />) if x else (<B />)` |

**Key Rules:**

1. Use Python-style: `(true) if condition else (false)`
2. Wrap JSX components in parentheses
3. For complex conditions, use if/else instead
