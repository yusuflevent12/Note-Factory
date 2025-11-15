from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from .. import schemas
from ..db.session import get_db
from .content import get_current_user

router = APIRouter()

@router.get("/me", response_model=schemas.UserRead)
def read_users_me(current_user: schemas.UserRead = Depends(get_current_user)):
    return current_user
