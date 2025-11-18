from fastapi import APIRouter, Depends, HTTPException, UploadFile, File, Form
from sqlalchemy.orm import Session
from typing import List, Optional

# "app" kök dizininden 'mutlak' importlar
from app.services import  content_service
from app.db.session import get_db
from app.schemas import content

router = APIRouter()

# 1. İÇERİKLERİ GETİR (Okuma)
@router.get("/{course_id}", response_model=List[content.ContentRead])
def read_content_by_course(
    course_id: int, 
    skip: int = 0, 
    limit: int = 100, 
    db: Session = Depends(get_db)
):
    """
    Belirli bir 'course_id'ye ait tüm içerikleri getir.
    """
    # Senin düzelttiğin 'content_service'i çağırıyor
    contents = content_service.get_content_by_course(
        db, course_id=course_id, skip=skip, limit=limit
    )
    return contents


# 2. İÇERİK YÜKLE (Yazma)
@router.post("/upload/", response_model=content.ContentRead)
async def create_upload_content(
    *,
    db: Session = Depends(get_db),
    # Form verileri (Flutter'dan gelenler)
    title: str = Form(...),
    content_type: content.ContentType = Form(...),
    course_id: int = Form(...),
    year: Optional[int] = Form(None),
    file: UploadFile = File(...),
    
    # Şimdilik testi kolaylaştırmak için sabit bir kullanıcı ID kullanıyoruz
    current_user_id: int = 1 
):
    """
    Yeni bir içerik yükler.
    """
    # "Garson Fişi"ni hazırla
    content_in =content.ContentCreate(
        title=title,
        content_type=content_type,
        course_id=course_id,
        year=year
    )

    # Senin düzelttiğin 'create_content' fonksiyonunu çağır
    try:
        content = await content_service.create_content(
            db=db, 
            content_in=content_in, 
            owner_id=current_user_id,
            file=file
        )
        return content
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Yükleme hatası: {str(e)}")