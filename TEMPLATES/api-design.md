# API Design Checklist

Use this checklist when designing REST APIs with FastAPI or any backend framework.

## API Planning

### Design
- [ ] Clear business requirements defined
- [ ] Resource entities identified
- [ ] API versioning strategy decided (`/api/v1/`)
- [ ] Authentication method chosen (JWT, OAuth2, API Key)
- [ ] Rate limiting strategy defined
- [ ] CORS policy configured
- [ ] Error handling strategy documented
- [ ] Response format standardized (JSON)
- [ ] Pagination strategy defined (limit/offset or cursor)

### Resource Design

For each resource:
- [ ] Resource name is plural and lowercase (`/users`, `/products`)
- [ ] Clear CRUD operations mapped to HTTP methods
- [ ] Relationship endpoints designed (`/users/{id}/posts`)
- [ ] Query parameters documented
- [ ] Path parameters validated
- [ ] Request body schema defined (Pydantic)
- [ ] Response schema defined (Pydantic)
- [ ] Status codes documented (200, 201, 400, 401, 404, 500)

### HTTP Methods
- [ ] `GET` - Retrieve resource(s)
- [ ] `POST` - Create new resource
- [ ] `PUT` - Replace entire resource
- [ ] `PATCH` - Update partial resource
- [ ] `DELETE` - Remove resource
- [ ] `HEAD` - Check resource existence
- [ ] `OPTIONS` - Retrieve available methods

## Implementation

### Input Validation
```python
from pydantic import BaseModel, EmailStr, Field

class UserCreate(BaseModel):
    email: EmailStr
    password: str = Field(..., min_length=8)
    first_name: str = Field(..., min_length=1, max_length=50)
```

- [ ] All inputs validated
- [ ] Type hints on all parameters
- [ ] Required fields marked
- [ ] Min/max lengths defined
- [ ] Email/URL format validated
- [ ] Enum values restricted
- [ ] Custom validators implemented

### Response Structure

```python
# Success response
{
  "status": "success",
  "data": {...}
}

# Error response
{
  "status": "error",
  "error": {
    "code": "INVALID_INPUT",
    "message": "Email is required",
    "details": {...}
  }
}
```

- [ ] Consistent response structure
- [ ] Status field included
- [ ] Error messages are user-friendly
- [ ] Error codes documented
- [ ] Detailed error info for debugging

### Authentication & Authorization

```python
from fastapi import Depends, HTTPException
from fastapi.security import HTTPBearer

security = HTTPBearer()

async def get_current_user(credentials = Depends(security)):
    token = credentials.credentials
    # Verify token
    return user

@app.post("/protected-resource")
async def protected(current_user = Depends(get_current_user)):
    return {"user_id": current_user.id}
```

- [ ] Authentication implemented
- [ ] Token validation
- [ ] Authorization checks
- [ ] Role-based access control (RBAC)
- [ ] Resource ownership validated
- [ ] Secure password hashing (bcrypt)
- [ ] No sensitive data in logs

### Logging & Monitoring

```python
import logging

logger = logging.getLogger(__name__)

@app.post("/users")
async def create_user(user: UserCreate):
    logger.info(f"Creating user: {user.email}")
    try:
        # Create user
        logger.info(f"User created: {user.email}")
    except Exception as e:
        logger.error(f"Failed to create user: {str(e)}")
        raise
```

- [ ] All requests logged
- [ ] Errors logged with context
- [ ] Performance metrics tracked
- [ ] No sensitive data logged
- [ ] Log levels appropriate (INFO, WARNING, ERROR)

### Testing

```python
# tests/test_users.py
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_create_user():
    response = client.post(
        "/api/v1/users",
        json={"email": "test@example.com", "password": "Test123!"}
    )
    assert response.status_code == 201
    assert response.json()["email"] == "test@example.com"

def test_create_user_invalid_email():
    response = client.post(
        "/api/v1/users",
        json={"email": "invalid", "password": "Test123!"}
    )
    assert response.status_code == 422

def test_unauthorized_access():
    response = client.get("/api/v1/users/me")
    assert response.status_code == 401
```

- [ ] Happy path tests
- [ ] Error case tests
- [ ] Edge case tests
- [ ] Authentication tests
- [ ] Authorization tests
- [ ] Validation tests
- [ ] Integration tests
- [ ] Test coverage >80%

## Security

- [ ] HTTPS enforced (in production)
- [ ] CORS properly configured
- [ ] SQL injection prevented (use ORM)
- [ ] XSS prevention (output encoding)
- [ ] CSRF tokens implemented (if needed)
- [ ] Rate limiting implemented
- [ ] Input sanitization
- [ ] Output escaping
- [ ] Secure headers set (HSTS, CSP)
- [ ] Secrets not hardcoded
- [ ] API keys rotated regularly
- [ ] Sensitive data encrypted

## Performance

```python
# Pagination
@app.get("/users")
async def list_users(
    skip: int = Query(0, ge=0),
    limit: int = Query(10, ge=1, le=100),
    db: Session = Depends(get_db)
):
    return db.query(User).offset(skip).limit(limit).all()

# Caching
from fastapi_cache2 import FastAPICache2
from fastapi_cache2.backends.redis import RedisBackend

@app.get("/users/{id}")
@cached(expire=300)
async def get_user(id: int, db: Session = Depends(get_db)):
    return db.query(User).filter(User.id == id).first()
```

- [ ] Pagination implemented
- [ ] Query optimization
- [ ] Indexes on frequently queried fields
- [ ] Caching strategy (Redis)
- [ ] N+1 queries avoided (eager loading)
- [ ] Large response handling
- [ ] Database connection pooling
- [ ] Query execution time monitored

## Documentation

```python
@app.post(
    "/users",
    response_model=UserResponse,
    status_code=201,
    summary="Create a new user",
    tags=["users"]
)
async def create_user(
    *,
    user: UserCreate,
    db: Session = Depends(get_db)
) -> UserResponse:
    """
    Create a new user account.
    
    - **email**: User's email address (must be unique)
    - **password**: User's password (minimum 8 characters)
    - **first_name**: User's first name
    
    Returns the created user object with ID.
    """
    return crud.create_user(db, user)
```

- [ ] Endpoint docstrings
- [ ] Parameter descriptions
- [ ] Response schema documented
- [ ] Error responses documented
- [ ] Examples provided
- [ ] Auto-generated Swagger docs enabled
- [ ] README with API overview
- [ ] Setup instructions
- [ ] Authentication guide
- [ ] Error codes reference

## Versioning & Maintenance

- [ ] API version in URL (`/api/v1/`)
- [ ] Backwards compatibility maintained
- [ ] Deprecation notices in docs
- [ ] Migration guide for breaking changes
- [ ] Changelog maintained
- [ ] Release notes documented

## Sample FastAPI Endpoint

```python
from fastapi import APIRouter, Depends, HTTPException, Query, Path
from sqlalchemy.orm import Session
from app.schemas import UserCreate, UserResponse
from app.crud import user as user_crud
from app.api import deps

router = APIRouter(
    prefix="/users",
    tags=["users"],
    responses={404: {"description": "Not found"}}
)

@router.post(
    "/",
    response_model=UserResponse,
    status_code=201,
    summary="Create a new user"
)
async def create_user(
    *,
    db: Session = Depends(deps.get_db),
    user_in: UserCreate,
):
    """
    Create a new user account.
    
    **Parameters:**
    - email: User's email address
    - password: User's password (min 8 chars)
    - first_name: User's first name
    """
    user = user_crud.get_by_email(db, user_in.email)
    if user:
        raise HTTPException(status_code=400, detail="Email already registered")
    return user_crud.create(db=db, obj_in=user_in)

@router.get(
    "/{user_id}",
    response_model=UserResponse,
    summary="Get a user by ID"
)
async def get_user(
    *,
    db: Session = Depends(deps.get_db),
    user_id: int = Path(..., gt=0),
):
    """
    Get a specific user by ID.
    """
    user = user_crud.get(db, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user

@router.get(
    "/",
    response_model=list[UserResponse],
    summary="List all users"
)
async def list_users(
    *,
    db: Session = Depends(deps.get_db),
    skip: int = Query(0, ge=0),
    limit: int = Query(10, ge=1, le=100),
):
    """
    List all users with pagination.
    """
    return user_crud.get_multi(db, skip=skip, limit=limit)
```

---

**Use this checklist for every API endpoint!**
