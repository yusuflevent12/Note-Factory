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

    model_config = {"from_attributes": True}

class VoteBase(BaseModel):
    value: int

class VoteCreate(VoteBase):
    pass

class VoteRead(VoteBase):
    id: int
    owner: UserRead

    model_config = {"from_attributes": True}

class ContentBase(BaseModel):
    title: str
    description: Optional[str] = None
    content_type: ContentType

class ContentCreate(ContentBase):
    course_id: int

class ContentRead(ContentBase):
    id: int
    file_url: str
    owner: UserRead
    comments: List[CommentRead] = []
    votes: List[VoteRead] = []

    model_config = {"from_attributes": True}
