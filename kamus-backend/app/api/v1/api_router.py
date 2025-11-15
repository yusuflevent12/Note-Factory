from fastapi import APIRouter
from .endpoints import auth, content, hierarchy, users

api_router = APIRouter()
api_router.include_router(auth.router, tags=["auth"])
api_router.include_router(users.router, prefix="/users", tags=["users"])
api_router.include_router(hierarchy.router, prefix="/hierarchy", tags=["hierarchy"])
api_router.include_router(content.router, prefix="/content", tags=["content"])
