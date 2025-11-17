from fastapi import APIRouter

# 1. "Jules"un (AI) oluşturduğu TÜM endpoint'leri (Aşçıları) import et
from .endpoints import auth, content, hierarchy, users

api_router = APIRouter()

# 2. TÜM Aşçıları Mutfak Şefi'ne (Router) tanıt

# '/api/v1/auth' ile başlayan tüm istekler -> auth.py'ye
api_router.include_router(
    auth.router, 
    prefix="/auth",  # <-- "JULES"UN (AI) UNUTTUĞU O "İNŞAAT" PARÇASI
    tags=["Auth"]
) 

# '/api/v1/users' ile başlayan tüm istekler -> users.py'ye
api_router.include_router(users.router, prefix="/users", tags=["Users"])

# '/api/v1/hierarchy' ile başlayan tüm istekler -> hierarchy.py'ye
api_router.include_router(hierarchy.router, prefix="/hierarchy", tags=["Hierarchy"])

# '/api/v1/content' ile başlayan tüm istekler -> content.py'ye
api_router.include_router(content.router, prefix="/content", tags=["Content"])