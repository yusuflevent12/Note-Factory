from fastapi import APIRouter, Depends, UploadFile, File, Form
from sqlalchemy.orm import Session
from typing import List
from .. import schemas, services, models
from ..db.session import get_db
from ..core.security import create_access_token, verify_password
from jose import jwt, JWTError
from fastapi.security import OAuth2PasswordBearer
from ..core.config import settings

router = APIRouter()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/v1/token")

def get_current_user(db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    credentials_exception = JWTError("Could not validate credentials")
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
        email: str = payload.get("sub")
        if email is None:
            raise credentials_exception
    except JWTError:
        raise credentials_exception
    user = services.user_service.get_user_by_email(db, email=email)
    if user is None:
        raise credentials_exception
    return user

@router.get("/{course_id}", response_model=List[schemas.ContentRead])
def read_content_by_course(course_id: int, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    contents = services.content_service.get_content_by_course(db, course_id=course_id, skip=skip, limit=limit)
    return contents

@router.post("/", response_model=schemas.ContentRead)
async def create_content(
    title: str = Form(...),
    description: str = Form(None),
    content_type: models.ContentType = Form(...),
    course_id: int = Form(...),
    file: UploadFile = File(...),
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user),
):
    content_create = schemas.ContentCreate(
        title=title,
        description=description,
        content_type=content_type,
        course_id=course_id,
    )
    return await services.content_service.create_content(
        db=db, content=content_create, owner_id=current_user.id, file=file
    )
