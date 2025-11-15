from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List
from app.models import  hierarchy
from app.db.session import get_db
from app.schemas import hierarchy

router = APIRouter()

@router.get("/universities", response_model=List[hierarchy.UniversityRead])
def read_universities(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    universities = db.query(hierarchy.University).offset(skip).limit(limit).all()
    return universities

@router.get("/faculties/{university_id}", response_model=List[hierarchy.FacultyRead])
def read_faculties(university_id: int, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    faculties = db.query(hierarchy.Faculty).filter(hierarchy.Faculty.university_id == university_id).offset(skip).limit(limit).all()
    return faculties

@router.get("/departments/{faculty_id}", response_model=List[hierarchy.DepartmentRead])
def read_departments(faculty_id: int, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    departments = db.query(hierarchy.Department).filter(hierarchy.Department.faculty_id == faculty_id).offset(skip).limit(limit).all()
    return departments

@router.get("/courses/{department_id}", response_model=List[hierarchy.CourseRead])
def read_courses(department_id: int, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    courses = db.query(hierarchy.Course).filter(hierarchy.Course.department_id == department_id).offset(skip).limit(limit).all()
    return courses
