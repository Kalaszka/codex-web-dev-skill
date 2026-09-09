# Full-Stack Project Setup Guide

This template provides a complete setup for a modern full-stack web application using:
- **Frontend:** React with TypeScript
- **Backend:** FastAPI (Python)
- **Database:** PostgreSQL
- **Containerization:** Docker
- **CI/CD:** GitHub Actions

## Project Structure

```
my-project/
├── frontend/                    # React + TypeScript
│   ├── src/
│   │   ├── components/         # Reusable React components
│   │   ├── pages/              # Page components
│   │   ├── hooks/              # Custom React hooks
│   │   ├── services/           # API calls
│   │   ├── types/              # TypeScript types
│   │   ├── styles/             # Global styles
│   │   └── App.tsx
│   ├── package.json
│   ├── tsconfig.json
│   └── Dockerfile
│
├── backend/                     # FastAPI
│   ├── app/
│   │   ├── api/
│   │   │   ├── routes/         # API endpoints
│   │   │   └── dependencies/   # Shared dependencies
│   │   ├── models/             # SQLAlchemy models
│   │   ├── schemas/            # Pydantic schemas
│   │   ├── crud/               # Database operations
│   │   ├── core/
│   │   │   ├── config.py       # Configuration
│   │   │   └── security.py     # Security utilities
│   │   └── main.py
│   ├── tests/
│   ├── requirements.txt
│   ├── alembic/                # Database migrations
│   └── Dockerfile
│
├── docker-compose.yml          # Multi-container setup
├── .github/
│   └── workflows/
│       ├── test.yml            # Run tests
│       └── deploy.yml          # Deploy to production
├── .env.example                # Environment variables template
└── README.md
```

## Setup Instructions

### 1. Prerequisites

```bash
# Install required tools
- Node.js 16+ (npm or yarn)
- Python 3.9+
- Docker & Docker Compose
- PostgreSQL (or use Docker)
```

### 2. Backend Setup

```bash
cd backend/

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Setup environment
cp .env.example .env
# Edit .env with your configuration

# Run migrations
alembic upgrade head

# Start development server
uvicorn app.main:app --reload
# API will be available at http://localhost:8000
# Docs at http://localhost:8000/docs
```

### 3. Frontend Setup

```bash
cd frontend/

# Install dependencies
npm install

# Create environment file
cp .env.example .env.local
# Set REACT_APP_API_URL=http://localhost:8000

# Start development server
npm start
# App will be available at http://localhost:3000
```

### 4. Database Setup

**Option A: Docker Compose (Recommended)**
```bash
cd project-root/
docker-compose up -d
# PostgreSQL will run on localhost:5432
```

**Option B: Local PostgreSQL**
```bash
# Create database
psql -U postgres -c "CREATE DATABASE my_project;"

# Set connection string in .env
DATABASE_URL=postgresql://user:password@localhost/my_project
```

### 5. Run with Docker Compose

```bash
# Build and start all services
docker-compose up --build

# Services:
# - Frontend: http://localhost:3000
# - Backend: http://localhost:8000
# - Database: localhost:5432
```

## Development Workflow

### Backend Development

```bash
cd backend/

# Write your route
cat > app/api/routes/users.py << 'EOF'
from fastapi import APIRouter
from app.schemas import UserCreate, User
from app.crud import user as user_crud
from app.api import deps

router = APIRouter()

@router.post("/", response_model=User)
def create_user(
    *,
    db: deps.SessionDep,
    user_in: UserCreate,
):
    """Create a new user."""
    return user_crud.create(db=db, obj_in=user_in)
EOF

# Write tests
cat > tests/api/test_users.py << 'EOF'
def test_create_user(client):
    response = client.post(
        "/api/v1/users/",
        json={"email": "test@example.com", "password": "test123"}
    )
    assert response.status_code == 200
EOF

# Run tests
pytest tests/

# Format code
black app/ tests/

# Lint
flake8 app/ tests/
```

### Frontend Development

```bash
cd frontend/

# Create a component
mkdir -p src/components/UserForm
cat > src/components/UserForm/UserForm.tsx << 'EOF'
import React, { useState } from 'react';
import { UserCreateRequest } from '../../types/user';

interface Props {
  onSubmit: (data: UserCreateRequest) => Promise<void>;
  isLoading?: boolean;
}

export const UserForm: React.FC<Props> = ({ onSubmit, isLoading }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    await onSubmit({ email, password });
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        placeholder="Email"
        required
      />
      <input
        type="password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        placeholder="Password"
        required
      />
      <button type="submit" disabled={isLoading}>
        {isLoading ? 'Creating...' : 'Create User'}
      </button>
    </form>
  );
};
EOF

# Run tests
npm test

# Lint
npm run lint

# Format
npm run format
```

## API Design Checklist

- [ ] All endpoints have clear purpose and naming
- [ ] Request/response schemas are defined (Pydantic)
- [ ] Authentication is implemented (JWT)
- [ ] Authorization checks are in place
- [ ] Input validation is present
- [ ] Error handling with meaningful messages
- [ ] Logging for debugging
- [ ] Rate limiting (if needed)
- [ ] CORS configured correctly
- [ ] API documentation (Swagger/OpenAPI)
- [ ] Tests for all happy paths
- [ ] Tests for error cases

## Database Migrations

```bash
cd backend/

# Create a new migration
alembic revision --autogenerate -m "Add user table"

# Apply migrations
alembic upgrade head

# Rollback
alembic downgrade -1

# View migration history
alembic current
alembic history
```

## Authentication Setup

### Backend (FastAPI)

```python
# app/core/security.py
from passlib.context import CryptContext
from datetime import datetime, timedelta
from jose import jwt

passwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
SECRET_KEY = "your-secret-key-change-in-production"
ALGORITHM = "HS256"

def hash_password(password: str) -> str:
    return passwd_context.hash(password)

def verify_password(plain: str, hashed: str) -> bool:
    return passwd_context.verify(plain, hashed)

def create_access_token(data: dict, expires_delta: timedelta = None) -> str:
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(hours=24)
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
```

### Frontend (React)

```typescript
// src/services/auth.ts
import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL;

export const authService = {
  login: async (email: string, password: string) => {
    const response = await axios.post(`${API_URL}/api/v1/login`, {
      username: email,
      password,
    });
    localStorage.setItem('token', response.data.access_token);
    return response.data;
  },

  logout: () => {
    localStorage.removeItem('token');
  },

  getToken: () => localStorage.getItem('token'),
};
```

## CI/CD Pipeline

### GitHub Actions Workflow

```yaml
# .github/workflows/test.yml
name: Tests

on: [push, pull_request]

jobs:
  backend:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:13
        env:
          POSTGRES_PASSWORD: postgres
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-python@v2
        with:
          python-version: '3.9'
      - run: pip install -r backend/requirements.txt
      - run: cd backend && pytest

  frontend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v2
        with:
          node-version: '16'
      - run: cd frontend && npm ci && npm test
```

## Deployment

### Docker Compose Production

```yaml
# docker-compose.prod.yml
version: '3.8'

services:
  db:
    image: postgres:13
    volumes:
      - postgres_data:/var/lib/postgresql/data
    environment:
      POSTGRES_DB: ${DB_NAME}
      POSTGRES_USER: ${DB_USER}
      POSTGRES_PASSWORD: ${DB_PASSWORD}

  backend:
    build: ./backend
    command: uvicorn app.main:app --host 0.0.0.0 --port 8000
    environment:
      DATABASE_URL: postgresql://${DB_USER}:${DB_PASSWORD}@db:5432/${DB_NAME}
      SECRET_KEY: ${SECRET_KEY}
    depends_on:
      - db

  frontend:
    build: ./frontend
    ports:
      - "80:80"
    depends_on:
      - backend

volumes:
  postgres_data:
```

### Deploy to Cloud (Heroku example)

```bash
# Install Heroku CLI
# Login
heroku login

# Create app
heroku create my-app

# Add PostgreSQL
heroku addons:create heroku-postgresql:hobby-dev

# Set environment variables
heroku config:set SECRET_KEY=your-secret-key

# Deploy
git push heroku main
```

## Monitoring & Logging

```python
# app/core/logging.py
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

logger = logging.getLogger(__name__)
```

## Best Practices Checklist

### Backend
- [ ] Use environment variables for secrets
- [ ] Implement proper error handling
- [ ] Add logging
- [ ] Write unit tests
- [ ] Use dependency injection
- [ ] Follow SOLID principles
- [ ] Add API documentation
- [ ] Implement rate limiting
- [ ] Use database transactions
- [ ] Validate all inputs

### Frontend
- [ ] Use TypeScript for type safety
- [ ] Component composition patterns
- [ ] State management (Redux/Context)
- [ ] Error boundaries
- [ ] Loading states
- [ ] Accessibility (ARIA labels)
- [ ] Responsive design (Apple HIG)
- [ ] Performance optimization
- [ ] Unit & integration tests
- [ ] Error handling

## Resources

- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [React Documentation](https://react.dev/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Docker Documentation](https://docs.docker.com/)
- [Apple HIG](https://developer.apple.com/design/human-interface-guidelines/)

---

**Ready to build? Start coding! 🚀**
