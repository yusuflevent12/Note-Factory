from pydantic import BaseModel, EmailStr, Field, ConfigDict
from typing import Optional
from app.models.user import UserRole

# 1. TEMEL ŞEMA (Base)
# Hem 'Create' hem 'Read' bu temeli kullanacak
class UserBase(BaseModel):
    email: EmailStr
    full_name: Optional[str] = None # (Frontend'den 'full_name' de gelecek)

# 2. GİRİŞ FİŞİ (Create)
# Frontend'den (Flutter) Kayıt Olurken gelen veri
class UserCreate(UserBase):
    # 2. '72 byte' HATASINI ÖNLEYEN LİMİT (Field) BURADA
    password: str = Field(..., min_length=6, max_length=72)

# 3. ÇIKIŞ FİŞİ (Read)
# Backend'den Frontend'e (Flutter) geri dönen veri
# (Not: ASLA 'password' içermez)
class UserRead(UserBase):
    id: int
    role: UserRole

    # 3. 'ConfigDict' ARTIK TANIMLI (Pydantic V2 kuralı)
    model_config = ConfigDict(from_attributes=True)