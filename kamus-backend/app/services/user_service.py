from sqlalchemy.orm import Session
    
    # "Jules" (AI) bu ikisini karıştırmıştı!
    # Kiler Kayıt Defteri (Veritabanı Tabloları):
from app import models 
    # Garson Sipariş Fişi (API Veri Kuralları):
from app import schemas 
    
from app.core import security # (Şifreleme için bu da gerekecek)
    
    
def get_user_by_email(db: Session, email: str):
        # HATA BURADAYDI: "user.User" (schemas.User) değil,
        # "models.user.User" (models.User) olmalı.
    return db.query(models.user.User).filter(models.user.User.email == email).first()
    
def create_user(db: Session, user: schemas.user.UserCreate):
        # Gelen "Garson Fişi"ni (schema.UserCreate) al
        
        # Şifreyi "Kiler"e (DB) koymadan önce şifrele (hash)
    hashed_password = security.get_password_hash(user.password)
        
        # Onu "Kiler Kaydı"na (models.User) dönüştür
    db_user = models.user.User(
            email=user.email,
            full_name=user.full_name,
            hashed_password=hashed_password
            # (Rolü 'student' olarak varsayılan (default) ayarlamıştık)
        )
        
    db.add(db_user) # Kiler'e (DB) ekle
    db.commit()      # Değişiklikleri kaydet
    db.refresh(db_user) # Kiler'den yeni ID'yi al
    return db_user