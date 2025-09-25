export const jacTabsData = [
    {
        filename: "ai_sentiment_analysis.jac",
        code: `
import from byllm { Model, Image }

glob llm = Model(model_name="gpt-4o");

obj MemoryDetails {
    has who: list[str];
    has what: str;
    has where: str;
}
sem MemoryDetails = "Extract people, event, place, and time from a photo";
sem MemoryDetails.who = "Names of people in the photo";  
sem MemoryDetails.what = "What is happening in the scene";
sem MemoryDetails.where = "Location or setting of the photo";

def extract_memory_details(
    image: Image, city: str
) -> MemoryDetails by llm();

with entry {
    img = Image("image.png");
    details = extract_memory_details(img, "Paris");
    print(details);
}`,
    },
    {
        filename: "oop_example.jac",
        code: `
node Landmark {
    has name: str;
    can react with Tourist entry {
        print("📸 Tourist visits", self.name);
        visit [-->];
    }
}

node Cafe {
    can react with Tourist entry {
        print("☕ Tourist gets coffee and continues exploring.");
        visit [-->];
    }
}

node Local {
    can react with Tourist entry {
        print("👋 Local greets the Tourist");
    }
}

walker Tourist {
    has visited: list = [];

    can start_trip with \`root entry {
        print("🚶 Begins the journey at", here);
        visit [-->];
    }
    can log_visit with Landmark exit {
        self.visited.append(here.name);
    }
    can end_trip with exit {
        print("🏁 Trip ended. Places seen:", self.visited);
    }
}

with entry {
    # Build world
    root ++> Local();
    root ++> Landmark(name="Eiffel Tower");
    root ++> Cafe();
    root ++> Landmark(name="Colosseum");

    # Send Tourist walking
    a = (root spawn Tourist());
    print("Tourist entity ID:", a.visited);
}
`,
    },
    {
        filename: "cloud_scaling.jac",
        code: `
walker memories {
    has current_user: str = "";

    can get_memories with \`root entry {
        report {
            "message": 
                  f"Hello {self.current_user}, here are your memories!"
        };
    }
}`,
    },
];

export const pythonTabsData = [
    {
        filename: "ai_sentiment_analysis.py",
        code: `
import json, base64
from openai import OpenAI

client = OpenAI()

tools = [{
    "type": "function",
    "function": {
        "name": "process_memory",
        "parameters": {
            "type": "object",
            "properties": {
                "who": {"type": "array", "items": {"type": "string"}},
                "what": {"type": "string"},
                "where": {"type": "string"}
            },
            "required": ["who", "what", "where"]
        }
    }
}]

SYS_PROMPT = """
# Goal
Extract structured memory details from the photo.

# Fields
- who: list of people or animals involved
- what: short description of the activity or event
- where: location or place mentioned

# Rules
- Only use details from the photo and user input
- Do not hallucinate or invent missing information
- Always return using the \`process_memory\` tool

# Guidance
- If some fields are missing, leave them empty
- Keep responses factual and concise
"""

with open("image.png", "rb") as f:
    image_b64 = base64.b64encode(f.read()).decode("utf-8")

messages = [
    {"role": "system", "content": SYS_PROMPT},
    {
        "role": "user",
        "content": [
            {"type": "text", "text": "Photo took in Paris."},
            {"type": "image_url", "image_url": {
                "url": f"data:image/png;base64,{image_b64}"}
            }
        ]
    }
]

response = client.chat.completions.create(
    model="gpt-4o",
    messages=messages,
    tools=tools,
    tool_choice={
        "type": "function", 
        "function": {"name": "process_memory"}
    }
)

result = json.loads(
    response.choices[0].message.tool_calls[0].function.arguments
)
print(result)
`,
    },
    {
        filename: "oop_example.py",
        code: `
class Landmark:
    def __init__(self, name):
        self.name = name
    
    def react(self, tourist):
        print("📸 Tourist visits", self.name)
        tourist.visited.append(self.name)

class Cafe:
    def react(self, tourist):
        print("☕ Tourist gets coffee and continues exploring.")

class Local:
    def react(self, tourist):
        print("👋 Local greets the Tourist")

class Tourist:
    def __init__(self):
        self.visited = []
    def start_trip(self, places):
        print("🚶 Begins the journey")
        for place in places:
            place.react(self)
        print("🏁 Trip ended. Places seen:", self.visited)

# Build world
places = [
    Local(),
    Landmark("Eiffel Tower"),
    Cafe(),
    Landmark("Colosseum")
]

# Send Tourist walking
tourist = Tourist()
tourist.start_trip(places)
`,
    },
    {
        filename: "cloud_scaling.py",
        code: `
from fastapi import FastAPI, Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer
from pydantic import BaseModel
from datetime import datetime, timedelta
import jwt, pymongo, hashlib

# --- App & Security Setup ---
app = FastAPI()
SECRET_KEY = "secret123"
ALGORITHM = "HS256"
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")

# --- MongoDB Setup ---
client = pymongo.MongoClient("mongodb://localhost:27017/")
db = client["mydb"]
users_collection = db["users"]

# --- Models ---
class User(BaseModel):
    username: str
    password: str


# --- Auth Helpers ---
def create_token(username: str):
    """Generate JWT token for a user."""
    payload = {
        "sub": username,
        "exp": datetime.utcnow() + timedelta(hours=1)
    }
    return jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)

def verify_token(token: str = Depends(oauth2_scheme)):
    """Decode and validate JWT token."""
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload["sub"]
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Token expired")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Invalid token")


# --- Routes ---
@app.post("/signup")
def signup(user: User):
    """Register a new user with hashed password."""
    hashed_pw = hashlib.sha256(user.password.encode()).hexdigest()

    if users_collection.find_one({"username": user.username}):
        raise HTTPException(status_code=400, detail="User already exists")

    users_collection.insert_one({
        "username": user.username, 
        "password": hashed_pw
    })
    return {"message": "User created successfully"}


@app.post("/login")
def login(user: User):
    """Authenticate user and return JWT token."""
    hashed_pw = hashlib.sha256(user.password.encode()).hexdigest()
    db_user = users_collection.find_one({
        "username": user.username, 
        "password": hashed_pw
    })

    if not db_user:
        raise HTTPException(
            status_code=400, 
            detail="Invalid username or password"
        )
    access_token = create_token(user.username)
    return {"access_token": access_token, "token_type": "bearer"}



@app.get("/memories/")
def get_memories(current_user: str = Depends(verify_token)):
    """Protected route: requires valid JWT token."""
    return {
        "message": f"Hello {current_user}, here are your memories!"
    }
`,
    },
];

export const tabsData = [
    {
        title: "Programming Abstractions for Al",
        summary:
            "Jac introduces programming abstractions designed for AI, making it easy to integrate LLMs and multimodal models directly into your code with minimal effort.",
        link: "https://www.jac-lang.org/learn/jac-byllm/with_llm/",
        diagram: {
            src: "/diagrams/image.png",
            fallback: "/diagrams/ai-abstractions-static.png",
            title: "AI Programming Abstractions Flow",
            description: "Visual representation of how AI models integrate seamlessly into Jac code",
            type: "animated"
        }
    },
    {
        title: "Object-spatial programming",
        summary:
            "Object-spatial programming in Jac lets you model, traverse, and manipulate rich object graphs, making it ideal for knowledge graphs, games, and more.",
        link: "https://www.jac-lang.org/jac_book/chapter_8/",
        diagram: {
            src: "/diagrams/object-spatial-diagram.gif",
            fallback: "/diagrams/object-spatial-static.png",
            title: "Object-Spatial Programming Flow",
            description: "Visual representation of nodes, walkers, and spatial relationships",
            type: "animated"
        }
    },
    {
        title: "Zero to Infinite Scale without Code Changes",
        summary:
            "Jac enables zero to infinite scale without code changes. Deploy your Jac apps from local to cloud with built-in scaling, persistence, and user management.",
        link: "https://www.jac-lang.org/learn/jac-cloud/introduction/",
        diagram: {
            src: "/diagrams/scaling-architecture.gif",
            fallback: "/diagrams/scaling-architecture-static.png",
            title: "Zero to Infinite Scale Architecture",
            description: "How Jac applications seamlessly scale from local to distributed systems",
            type: "animated"
        }
    },
];
