---
title: useEffect
description: Using useEffect for side effects in JAC-Client.
---

---

## Basic Syntax

### JavaScript/React vs JAC-Client

```javascript tab="JavaScript/React"
useEffect(() => {
  console.log("Effect ran");
}, [dependency]);
```

```python tab="JAC-Client"
useEffect(lambda -> None {
    console.log("Effect ran");
}, [dependency]);
```

---

## Import useEffect

```python
cl import from react { useState, useEffect }

cl {
    def Component() -> any {
        [count, setCount] = useState(0);

        useEffect(lambda -> None {
            console.log("Count changed:", count);
        }, [count]);

        return <button onClick={lambda: setCount(count + 1)}>{count}</button>;
    }
}
```

---

## Effect Patterns

### On Mount (Run Once)

Empty dependency array runs only on mount:

```javascript tab="JavaScript"
useEffect(() => {
  console.log("Mounted");
}, []);
```

```python tab="JAC-Client"
useEffect(lambda -> None {
    console.log("Component mounted");
}, []);
```

### On Dependency Change

Runs when dependencies change:

```python
[count, setCount] = useState(0);

useEffect(lambda -> None {
    console.log("Count is now:", count);
    document.title = "Count: " + count.toString();
}, [count]);
```

### On Every Render

No dependency array (use sparingly):

```python
useEffect(lambda -> None {
    console.log("Rendered");
});
```

---

## Cleanup Function

```javascript tab="JavaScript/React"
useEffect(() => {
  const timer = setInterval(() => tick(), 1000);
  return () => clearInterval(timer);
}, []);
```

```python tab="JAC-Client"
useEffect(lambda -> None {
    timer = setInterval(lambda -> None { tick(); }, 1000);
    return lambda -> None { clearInterval(timer); };
}, []);
```

---

## Common Use Cases

### Fetching Data

```python
cl import from react { useState, useEffect }

cl {
    def UserList() -> any {
        [users, setUsers] = useState([]);
        [loading, setLoading] = useState(True);
        [error, setError] = useState(None);

        useEffect(lambda -> None {
            async def fetchUsers() {
                try {
                    response = await fetch("/api/users");
                    data = await response.json();
                    setUsers(data);
                } except {
                    setError("Failed to fetch users");
                } finally {
                    setLoading(False);
                }
            }
            fetchUsers();
        }, []);

        if loading {
            return <p>Loading...</p>;
        }

        if error {
            return <p>Error: {error}</p>;
        }

        def renderUser(user: dict, index: int) -> any {
            return <li key={user["id"]}>{user["name"]}</li>;
        }

        return <ul>{users.map(renderUser)}</ul>;
    }
}
```

### Timer/Interval

```python
def Timer() -> any {
    [seconds, setSeconds] = useState(0);
    [isRunning, setIsRunning] = useState(False);

    useEffect(lambda -> None {
        if not isRunning {
            return lambda -> None {};
        }

        timer = setInterval(lambda -> None {
            setSeconds(seconds + 1);
        }, 1000);

        return lambda -> None {
            clearInterval(timer);
        };
    }, [isRunning, seconds]);

    return (
        <div>
            <p>Time: {seconds}s</p>
            <button onClick={lambda: setIsRunning(not isRunning)}>
                {("Stop") if isRunning else ("Start")}
            </button>
            <button onClick={lambda -> None { setSeconds(0); setIsRunning(False); }}>
                Reset
            </button>
        </div>
    );
}
```

### Event Listeners

```python
def WindowSize() -> any {
    [size, setSize] = useState({
        "width": window.innerWidth,
        "height": window.innerHeight
    });

    useEffect(lambda -> None {
        def handleResize() -> None {
            setSize({
                "width": window.innerWidth,
                "height": window.innerHeight
            });
        }

        window.addEventListener("resize", handleResize);

        return lambda -> None {
            window.removeEventListener("resize", handleResize);
        };
    }, []);

    return (
        <p>Window: {size["width"]} x {size["height"]}</p>
    );
}
```

### Document Title

```python
def Counter() -> any {
    [count, setCount] = useState(0);

    useEffect(lambda -> None {
        document.title = "Count: " + count.toString();
    }, [count]);

    return (
        <button onClick={lambda: setCount(count + 1)}>
            Count: {count}
        </button>
    );
}
```

### Local Storage

```python
def PersistentCounter() -> any {
    # Initialize from localStorage
    [count, setCount] = useState(lambda -> int {
        saved = localStorage.getItem("count");
        return (parseInt(saved)) if saved else (0);
    });

    # Save to localStorage on change
    useEffect(lambda -> None {
        localStorage.setItem("count", count.toString());
    }, [count]);

    return (
        <div>
            <p>Count: {count}</p>
            <button onClick={lambda: setCount(count + 1)}>+</button>
            <button onClick={lambda: setCount(0)}>Reset</button>
        </div>
    );
}
```

---

## Multiple Effects

```python
def Dashboard() -> any {
    [user, setUser] = useState(None);
    [notifications, setNotifications] = useState([]);

    # Effect 1: Fetch user on mount
    useEffect(lambda -> None {
        async def fetchUser() {
            response = await fetch("/api/user");
            data = await response.json();
            setUser(data);
        }
        fetchUser();
    }, []);

    # Effect 2: Fetch notifications when user changes
    useEffect(lambda -> None {
        if user == None {
            return lambda -> None {};
        }

        async def fetchNotifications() {
            response = await fetch("/api/notifications/" + user["id"].toString());
            data = await response.json();
            setNotifications(data);
        }
        fetchNotifications();

        return lambda -> None {};
    }, [user]);

    # Effect 3: Update document title
    useEffect(lambda -> None {
        count = notifications.length;
        document.title = ("(" + count.toString() + ") Dashboard") if count > 0 else ("Dashboard");
    }, [notifications]);

    return <div>Dashboard</div>;
}
```

---

## Effect with Async/Await

```python
def DataFetcher() -> any {
    [data, setData] = useState(None);
    [loading, setLoading] = useState(True);

    useEffect(lambda -> None {
        # Define async function inside effect
        async def fetchData() {
            setLoading(True);
            try {
                response = await fetch("/api/data");
                result = await response.json();
                setData(result);
            } except {
                console.log("Error fetching data");
            } finally {
                setLoading(False);
            }
        }

        # Call the async function
        fetchData();
    }, []);

    if loading {
        return <p>Loading...</p>;
    }

    return <pre>{JSON.stringify(data, None, 2)}</pre>;
}
```

---

## Conditional Effects

```python
def Search() -> any {
    [query, setQuery] = useState("");
    [results, setResults] = useState([]);

    useEffect(lambda -> None {
        # Only search if query has content
        if query.trim() == "" {
            setResults([]);
            return lambda -> None {};
        }

        async def search() {
            response = await fetch("/api/search?q=" + query);
            data = await response.json();
            setResults(data);
        }

        # Debounce with timeout
        timeoutId = setTimeout(lambda -> None { search(); }, 300);

        return lambda -> None {
            clearTimeout(timeoutId);
        };
    }, [query]);

    return (
        <div>
            <input
                value={query}
                onChange={lambda e: any -> None { setQuery(e.target.value); }}
                placeholder="Search..."
            />
            <ul>
                {results.map(lambda item: dict, i: int -> any {
                    return <li key={i}>{item["name"]}</li>;
                })}
            </ul>
        </div>
    );
}
```

---

## Summary

| Pattern      | JavaScript                   | JAC-Client                             |
| ------------ | ---------------------------- | -------------------------------------- |
| Basic effect | `useEffect(() => {})`        | `useEffect(lambda -> None {})`         |
| With deps    | `useEffect(() => {}, [dep])` | `useEffect(lambda -> None {}, [dep])`  |
| On mount     | `useEffect(() => {}, [])`    | `useEffect(lambda -> None {}, [])`     |
| Cleanup      | `return () => cleanup()`     | `return lambda -> None { cleanup(); }` |
