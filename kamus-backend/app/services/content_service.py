from sqlalchemy.orm import Session, joinedload
import os
from fastapi import UploadFile

# "Jules"un (AI) hatasını (isim çakışması) düzeltiyoruz
# İkisini de 'app' kökünden 'mutlak' (absolute) import et
from app.models import content as mcontent   # <-- BU KİLER DEFTERİ (Veritabanı Tabloları)
from app.schemas import content   # <-- BU GARSON FİŞİ (API Verisi)

UPLOAD_DIRECTORY = "uploads"
if not os.path.exists(UPLOAD_DIRECTORY):
    os.makedirs(UPLOAD_DIRECTORY)

#
# 'models.content.Content' (Kiler Defteri) KULLAN
#
def get_content_by_course(db: Session, course_id: int, skip: int = 0, limit: int = 100):
    # Eager loading ile owner, comments, votes relationships'lerini yükle
    return db.query(mcontent.Content)\
             .options(
                 joinedload(mcontent.Content.owner),
                 joinedload(mcontent.Content.comments).joinedload("owner"),
                 joinedload(mcontent.Content.votes).joinedload("owner")
             )\
             .filter(mcontent.Content.course_id == course_id)\
             .offset(skip)\
             .limit(limit)\
             .all()

#
# 'schemas.content.ContentCreate' (Garson Fişi) AL
# 'models.content.Content' (Kiler Defteri) OLUŞTUR
#
async def create_content(db: Session, content_in: content.ContentCreate, owner_id: int, file: UploadFile):
    
    # (Dosya kaydetme mantığın doğru)
    file_path = os.path.join(UPLOAD_DIRECTORY, file.filename)
    with open(file_path, "wb") as buffer:
        buffer.write(await file.read())

    # HATA 2 ve 3 BURADAYDI:
    # "Garson Fişi"ni (schema) "Kiler Kaydı"na (model) dönüştür
    db_content = mcontent.Content(
        **content_in.model_dump(), # HATA 4: .dict() değil, .model_dump()
        owner_id=owner_id,
        file_url=file_path  # (Modelimizdeki 'file_url' alanını kullanıyoruz)
    )
    
    db.add(db_content)
    db.commit()
    db.refresh(db_content)
    
    # Owner'ı eager load et
    db_content = db.query(mcontent.Content)\
                   .options(joinedload(mcontent.Content.owner))\
                   .filter(mcontent.Content.id == db_content.id)\
                   .first()
    
    return db_content