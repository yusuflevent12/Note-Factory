from fastapi import APIRouter, Depends, HTTPException, UploadFile, File, Form
from sqlalchemy.orm import Session
from typing import List, Optional

# "app" kök dizininden 'mutlak' importlar
from app.api.v1.endpoints.auth import get_current_user
from app.services import content_service
from app.db.session import get_db
from app.schemas import content

router = APIRouter()


@router.get("/{course_id}", response_model=List[content.ContentRead])
def read_content_by_course(
    course_id: int, 
    skip: int = 0, 
    limit: int = 100, 
    db: Session = Depends(get_db)
):
    """
    Belirli bir 'course_id'ye ait tüm içerikleri (notlar, slaytlar) getir.
    """
    try:
        contents = content_service.get_content_by_course(
            db, course_id=course_id, skip=skip, limit=limit
        )
        return contents
    except Exception as e:
        import traceback
        raise HTTPException(
            status_code=500, 
            detail=f"İçerikler yüklenirken hata oluştu: {str(e)}\n{traceback.format_exc()}"
        )


#
# "JULES"UN (AI) EKSİK BIRAKTIĞI "İNŞAAT" (YÜKLEME) BURADA BAŞLIYOR
#
@router.post("/upload/")
async def create_upload_content(
    *,
    db: Session = Depends(get_db),
    # Not: Flutter (Dio) 'FormData' gönderecek.
    # Bu yüzden 'Form' kullanıyoruz.
    title: str = Form(...),
    content_type: content.ContentType = Form(...),
    course_id: int = Form(...),
    description: Optional[str] = Form(None),
    year: Optional[int] = Form(None),
    file: UploadFile = File(...),
    current_user = Depends(get_current_user),
):
    """
    Yeni bir içerik (Not, Slayt, Çıkmış Soru) ve dosyasını yükler.
    """
    try:
        # 1. "Garson Fişi"ni (Schema) manuel olarak oluştur
        content_in = content.ContentCreate(
            title=title,
            description=description,
            content_type=content_type,
            course_id=course_id
            # (file_url ve owner_id 'service' içinde eklenecek)
        )

        # 2. "Aşçı"ya (Service) siparişi ver
        content_obj = await content_service.create_content(
            db=db, 
            content_in=content_in, 
            owner_id=current_user.id,
            file=file
        )
        
        # 3. Schema'ya dönüştür
        try:
            content_read = content.ContentRead.model_validate(content_obj)
            return content_read
        except Exception as schema_error:
            import json
            content_data = {
                "id": getattr(content_obj, 'id', None),
                "title": getattr(content_obj, 'title', None),
                "description": getattr(content_obj, 'description', None),
                "content_type": str(getattr(content_obj, 'content_type', None)),
                "file_url": getattr(content_obj, 'file_url', None),
                "owner_id": getattr(content_obj, 'owner_id', None),
            }
            raise HTTPException(
                status_code=500,
                detail=f"Schema validation hatası: {str(schema_error)}\nContent data: {json.dumps(content_data, default=str)}"
            )
    except HTTPException:
        raise
    except Exception as e:
        import traceback
        # (Dosya kaydetme hatası vb.)
        raise HTTPException(
            status_code=500, 
            detail=f"Dosya yüklenirken hata oluştu: {str(e)}\n{traceback.format_exc()}"
        )