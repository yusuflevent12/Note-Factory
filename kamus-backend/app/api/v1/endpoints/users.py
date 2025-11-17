from fastapi import APIRouter, Depends

from app.api.v1.endpoints.auth import get_current_user
from app import models
from app.schemas import user

router = APIRouter()

@router.get("/me", response_model=user.UserRead)
def read_users_me(current_user: models.user.User = Depends(get_current_user)):
    return current_user
