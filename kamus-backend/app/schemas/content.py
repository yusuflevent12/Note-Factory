from pydantic import BaseModel
from typing import List, Optional
from app.models.content import ContentType
from .user import UserRead

class CommentBase(BaseModel):
    text: str

class CommentCreate(CommentBase):
    pass

class CommentRead(CommentBase):
    id: int
    owner: UserRead

    class Config:
        orm_mode = True

class VoteBase(BaseModel):
    value: int

class VoteCreate(VoteBase):
    pass

class VoteRead(VoteBase):
    id: int
    owner: UserRead

    class Config:
        orm_mode = True

class ContentBase(BaseModel):
    title: str
    description: Optional[str] = None
    content_type: ContentType

class ContentCreate(ContentBase):
    course_id: int

class ContentRead(ContentBase):
    id: int
    file_path: str
    owner: UserRead
    comments: List[CommentRead] = []
    votes: List[VoteRead] = []

    class Config:
        orm_mode = True
