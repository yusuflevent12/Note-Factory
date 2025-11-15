from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from app.db.base import Base

class University(Base):
    __tablename__ = "universities"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), index=True, nullable=False)
    faculties = relationship("Faculty", back_populates="university")

class Faculty(Base):
    __tablename__ = "faculties"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), index=True, nullable=False)
    university_id = Column(Integer, ForeignKey("universities.id"))
    university = relationship("University", back_populates="faculties")
    departments = relationship("Department", back_populates="faculty")

class Department(Base):
    __tablename__ = "departments"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), index=True, nullable=False)
    faculty_id = Column(Integer, ForeignKey("faculties.id"))
    faculty = relationship("Faculty", back_populates="departments")
    courses = relationship("Course", back_populates="department")

class Course(Base):
    __tablename__ = "courses"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), index=True, nullable=False)
    department_id = Column(Integer, ForeignKey("departments.id"))
    department = relationship("Department", back_populates="courses")
    contents = relationship("Content", back_populates="course")
