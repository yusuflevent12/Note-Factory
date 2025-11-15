from sqlalchemy.orm import Session
from app.models import content
import os
from fastapi import UploadFile
from app.schemas import content

UPLOAD_DIRECTORY = "uploads"
if not os.path.exists(UPLOAD_DIRECTORY):
    os.makedirs(UPLOAD_DIRECTORY)

def get_content_by_course(db: Session, course_id: int, skip: int = 0, limit: int = 100):
    return db.query(content.Content).filter(content.Content.course_id == course_id).offset(skip).limit(limit).all()

async def create_content(db: Session, content: content.ContentCreate, owner_id: int, file: UploadFile):
    file_path = os.path.join(UPLOAD_DIRECTORY, file.filename)
    with open(file_path, "wb") as buffer:
        buffer.write(await file.read())

    db_content = content.Content(
        **content.dict(),
        owner_id=owner_id,
        file_path=file_path
    )
    db.add(db_content)
    db.commit()
    db.refresh(db_content)
    return db_content
