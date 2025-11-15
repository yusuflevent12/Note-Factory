from sqlalchemy.orm import Session
from .. import models, schemas
import os
from fastapi import UploadFile

UPLOAD_DIRECTORY = "uploads"
if not os.path.exists(UPLOAD_DIRECTORY):
    os.makedirs(UPLOAD_DIRECTORY)

def get_content_by_course(db: Session, course_id: int, skip: int = 0, limit: int = 100):
    return db.query(models.Content).filter(models.Content.course_id == course_id).offset(skip).limit(limit).all()

async def create_content(db: Session, content: schemas.ContentCreate, owner_id: int, file: UploadFile):
    file_path = os.path.join(UPLOAD_DIRECTORY, file.filename)
    with open(file_path, "wb") as buffer:
        buffer.write(await file.read())

    db_content = models.Content(
        **content.dict(),
        owner_id=owner_id,
        file_path=file_path
    )
    db.add(db_content)
    db.commit()
    db.refresh(db_content)
    return db_content
