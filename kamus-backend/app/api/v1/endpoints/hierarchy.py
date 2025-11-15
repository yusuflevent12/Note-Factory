from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List
from .. import models, schemas
from db.session import get_db

router = APIRouter()

@router.get("/universities", response_model=List[schemas.UniversityRead])
def read_universities(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    universities = db.query(models.University).offset(skip).limit(limit).all()
    return universities

@router.get("/faculties/{university_id}", response_model=List[schemas.FacultyRead])
def read_faculties(university_id: int, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    faculties = db.query(models.Faculty).filter(models.Faculty.university_id == university_id).offset(skip).limit(limit).all()
    return faculties

@router.get("/departments/{faculty_id}", response_model=List[schemas.DepartmentRead])
def read_departments(faculty_id: int, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    departments = db.query(models.Department).filter(models.Department.faculty_id == faculty_id).offset(skip).limit(limit).all()
    return departments

@router.get("/courses/{department_id}", response_model=List[schemas.CourseRead])
def read_courses(department_id: int, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    courses = db.query(models.Course).filter(models.Course.department_id == department_id).offset(skip).limit(limit).all()
    return courses
