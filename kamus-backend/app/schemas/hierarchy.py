from pydantic import BaseModel
from typing import List

class CourseBase(BaseModel):
    name: str

class CourseRead(CourseBase):
    id: int

    class Config:
        orm_mode = True

class DepartmentBase(BaseModel):
    name: str

class DepartmentRead(DepartmentBase):
    id: int
    courses: List[CourseRead] = []

    class Config:
        orm_mode = True

class FacultyBase(BaseModel):
    name: str

class FacultyRead(FacultyBase):
    id: int
    departments: List[DepartmentRead] = []

    class Config:
        orm_mode = True

class UniversityBase(BaseModel):
    name: str

class UniversityRead(UniversityBase):
    id: int
    faculties: List[FacultyRead] = []

    class Config:
        orm_mode = True
