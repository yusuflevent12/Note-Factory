from sqlalchemy import Column, Integer, String, Enum
from sqlalchemy.orm import relationship
from app.db.base import Base
import enum

class UserRole(str, enum.Enum):
    student = "student"
    instructor = "instructor"
    admin = "admin"

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String(255), unique=True, index=True, nullable=False)
    hashed_password = Column(String(255), nullable=False)
    role = Column(Enum(UserRole), nullable=False, default=UserRole.student)
    full_name = Column(String(255), index=True, nullable=True) # (nullable=True -> İsteğe bağlı)
    contents = relationship("Content", back_populates="owner")
    comments = relationship("Comment", back_populates="owner")
    votes = relationship("Vote", back_populates="owner")
