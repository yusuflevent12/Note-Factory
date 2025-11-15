/kampus-cekirdegi-backend
├── /app                  # Ana Python paketi
│   ├── /api              # API endpoint (URL) yönetimi
│   │   ├── /v1           # API'nin 1. versiyonu (Gelecekte v2 eklemek için)
│   │   │   ├── api_router.py     # v1'deki tüm endpoint'leri birleştirir
│   │   │   └── /endpoints  # Asıl işi yapan URL'ler
│   │   │       ├── auth.py       # (POST /login, POST /register) - Kullanıcı girişi/kaydı
│   │   │       ├── users.py      # (GET /users/me) - Kullanıcı profil yönetimi
│   │   │       ├── hierarchy.py  # (GET /universities) - İçerik hiyerarşisi (Üni, Fakülte, Bölüm, Ders)
│   │   │       └── content.py    # (GET /content, POST /content) - Asıl içerik (not) işlemleri
│   │
│   ├── /core             # Uygulama genelindeki ayarlar
│   │   ├── config.py     # .env dosyasından ayarları (DB URL, JWT Secret) okur
│   │   └── security.py   # Şifreleme (hashing) ve JWT (token) oluşturma/doğrulama
│   │
│   ├── /db               # Veritabanı bağlantı mantığı
│   │   ├── base.py       # Modellerin miras alacağı temel SQLAlchemy sınıfı
│   │   └── session.py    # Her istek (request) için veritabanı oturumu (session) yönetir
│   │
│   ├── /models           # Veritabanı Tabloları (SQLAlchemy)
│   │   ├── user.py       # 'User' tablosu (Öğrenci, Hoca, Admin rolleri)
│   │   ├── hierarchy.py  # 'University', 'Faculty', 'Department', 'Course' tabloları
│   │   └── content.py    # 'Content' (not/slayt), 'Vote' (oy), 'Comment' (yorum) tabloları
│   │
│   ├── /schemas          # API Veri Kuralları (Pydantic)
│   │   ├── user.py       # (UserCreate, UserRead) - API'ye gelen/giden 'User' verisinin nasıl görünmesi gerektiği
│   │   ├── content.py    # (ContentCreate, ContentRead) - İçerik yükleme/okuma şemaları (Tüm etiketler burada!)
│   │   └── token.py      # Giriş yapıldığında dönen token'ın şeması
│   │
│   ├── /services         # Asıl İş Mantığı (Business Logic)
│   │   ├── user_service.py     # Kullanıcı oluşturma (şifreyi hash'leme vb.)
│   │   └── content_service.py  # İçerik yükleme (Dosyayı Storage'a, metadatayı DB'ye kaydetme)
│   │
│   └── main.py           # FastAPI uygulamasını başlatan, tüm bileşenleri (router, db) birleştiren ana dosya
│
├── /tests                # Kodun çalıştığını doğrulayan testler (Çok önemli!)
├── .env                  # Veritabanı şifresi, API anahtarları gibi GİZLİ bilgiler
├── .gitignore            # Git'e yüklenmemesi gereken dosyalar (örn: .env, __pycache__)
├── Dockerfile            # (Opsiyonel) Projeyi "paketlemek" için
└── requirements.txt      # Gerekli Python kütüphaneleri (fastapi, uvicorn, sqlalchemy...)