from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List

# "Jules"un (AI) hatasını (isim çakışması) düzeltiyoruz
# İkisini de 'app' kökünden 'mutlak' (absolute) import et
from app.models import hierarchy  as mhierarchy  # <-- BU KİLER DEFTERİ (Veritabanı Tabloları)
from app.schemas import hierarchy   # <-- BU GARSON FİŞİ (API Verisi)
from app.db.session import get_db

router = APIRouter()

#
# 'schemas.hierarchy.UniversityRead' (Fiş) DÖNDÜR
#
@router.get("/universities", response_model=List[hierarchy.UniversityRead])
def read_universities(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    # Kiler'den (models.hierarchy.University) ÇEK
    universities = db.query(mhierarchy.University).offset(skip).limit(limit).all()
    return universities

#
# 'schemas.hierarchy.FacultyRead' (Fiş) DÖNDÜR
#
@router.get("/faculties/{university_id}", response_model=List[hierarchy.FacultyRead])
def read_faculties(university_id: int, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    # Kiler'den (models.hierarchy.Faculty) ÇEK
    faculties = db.query(mhierarchy.Faculty).filter(mhierarchy.Faculty.university_id == university_id).offset(skip).limit(limit).all()
    return faculties

#
# 'schemas.hierarchy.DepartmentRead' (Fiş) DÖNDÜR
#
@router.get("/departments/{faculty_id}", response_model=List[hierarchy.DepartmentRead])
def read_departments(faculty_id: int, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    # Kiler'den (models.hierarchy.Department) ÇEK
    departments = db.query(mhierarchy.Department).filter(mhierarchy.Department.faculty_id == faculty_id).offset(skip).limit(limit).all()
    return departments

#
# 'schemas.hierarchy.CourseRead' (Fiş) DÖNDÜR
#
@router.get("/courses/{department_id}", response_model=List[hierarchy.CourseRead])
def read_courses(department_id: int, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    # Kiler'den (models.hierarchy.Course) ÇEK
    # HATA TAM OLARAK BU SATIRDAYDI (models.hierarchy.Course olmalıydı)
    courses = db.query(mhierarchy.Course).filter(mhierarchy.Course.department_id == department_id).offset(skip).limit(limit).all()
    return courses