from pydantic import BaseModel
from typing import List, Optional

# --- Course (Ders) Şemaları ---

class CourseBase(BaseModel):
    name: str
    course_code: Optional[str] = None
    department_id: int

class CourseCreate(CourseBase):
    pass

class CourseRead(CourseBase):
    id: int
    
    # SQLAlchemy'nin ilişkiyi otomatik olarak okuması için
    model_config = {"from_attributes": True} 

# --- Department (Bölüm) Şemaları ---

class DepartmentBase(BaseModel):
    name: str
    faculty_id: int

class DepartmentCreate(DepartmentBase):
    pass

class DepartmentRead(DepartmentBase):
    id: int
    # Bir bölüm okunduğunda, içindeki dersleri de (CourseRead) listele
    courses: List[CourseRead] = []
    
    model_config = {"from_attributes": True}

# --- Faculty (Fakülte) Şemaları ---

class FacultyBase(BaseModel):
    name: str
    university_id: int

class FacultyCreate(FacultyBase):
    pass

class FacultyRead(FacultyBase):
    id: int
    # Bir fakülte okunduğunda, içindeki bölümleri de (DepartmentRead) listele
    departments: List[DepartmentRead] = []
    
    model_config = {"from_attributes": True}

# --- University (Üniversite) Şemaları ---

class UniversityBase(BaseModel):
    name: str

class UniversityCreate(UniversityBase):
    pass

class UniversityRead(UniversityBase):
    id: int
    # Bir üniversite okunduğunda, içindeki fakülteleri de (FacultyRead) listele
    faculties: List[FacultyRead] = []
    
    model_config = {"from_attributes": True}