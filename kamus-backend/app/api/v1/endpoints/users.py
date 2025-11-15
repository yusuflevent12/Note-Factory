from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.schemas import user
from app.db.session import get_db
from .content import get_current_user

router = APIRouter()

@router.get("/me", response_model=user.UserRead)
def read_users_me(current_user: user.UserRead = Depends(get_current_user)):
    return current_user
