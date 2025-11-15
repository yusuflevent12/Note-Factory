from sqlalchemy import Column, Integer, String, Enum, ForeignKey, Text
from sqlalchemy.orm import relationship
from app.db.base import Base
import enum

class ContentType(str, enum.Enum):
    lecture_note = "lecture_note"
    past_exam = "past_exam"
    slide = "slide"

class Content(Base):
    __tablename__ = "contents"
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(255), index=True, nullable=False)
    description = Column(Text)
    file_path = Column(String(255), nullable=False)
    content_type = Column(Enum(ContentType), nullable=False)
    owner_id = Column(Integer, ForeignKey("users.id"))
    owner = relationship("User", back_populates="contents")
    course_id = Column(Integer, ForeignKey("courses.id"))
    course = relationship("Course", back_populates="contents")
    comments = relationship("Comment", back_populates="content")
    votes = relationship("Vote", back_populates="content")

class Comment(Base):
    __tablename__ = "comments"
    id = Column(Integer, primary_key=True, index=True)
    text = Column(Text, nullable=False)
    owner_id = Column(Integer, ForeignKey("users.id"))
    owner = relationship("User", back_populates="comments")
    content_id = Column(Integer, ForeignKey("contents.id"))
    content = relationship("Content", back_populates="comments")

class Vote(Base):
    __tablename__ = "votes"
    id = Column(Integer, primary_key=True, index=True)
    value = Column(Integer, nullable=False)  # -1 for downvote, 1 for upvote
    owner_id = Column(Integer, ForeignKey("users.id"))
    owner = relationship("User", back_populates="votes")
    content_id = Column(Integer, ForeignKey("contents.id"))
    content = relationship("Content", back_populates="votes")
