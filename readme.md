Proje: Kampüs Çekirdeği (NoteFactory)
Kampüs Çekirdeği, üniversite öğrencilerinin ders içeriklerine (slayt, çıkmış soru, not) tek bir yerden, organize bir şekilde erişmesini sağlayan ve bu içerikler etrafında bir topluluk oluşturmayı hedefleyen ölçeklenebilir bir SaaS platformudur.

🚀 Projenin Misyonu ve Çözdüğü Sorun
Üniversite öğrencilerinin en büyük "angaryası" ders materyallerini bulmaktır. Mevcut içerik; dağınık (WhatsApp, Google Drive), eksik ("hocanın slaytı yok", "kimse not tutmuyor"), kategorize edilmemiş ("bu vize mi final mi?") ve kalitesizdir.

Kampüs Çekirdeği bu sorunu şu şekilde çözer:

"Cold Start" (İlk Yükleme) Angaryasını Üstlenerek: Platform, kurucular tarafından manuel olarak yüklenen, "hiper-odaklı" (örn: Erciyes Üni. Yazılım Bölümü) ve etiketlenmiş bir çekirdek içerik (slayt, çıkmış soru) ile başlar.

Topluluk Motoru: Kullanıcıların (öğrencilerin) kendi içeriklerini yüklemesini, oylamasını ve tartışmasını sağlayarak platformun kendi kendini büyütmesini sağlar.

AI Destek: Gelecekte, bu içerikleri "akıllı" hale getirerek (özetleme, test hazırlama) pasif bir kütüphaneden aktif bir asistana dönüşür.

🎯 Temel Özellikler (MVP & Vizyon)
Uygulamamızın sunduğu ve sunacağı değerler:

MVP (Minimum Uygulanabilir Ürün) Özellikleri
Hiper-Odaklı İçerik Kütüphanesi:

Hiper-Odaklı Başlangıç: Sadece belirli bir niş'e (örn: Erciyes Üni. Yazılım Bölümü) odaklanmış, "rafları dolu" bir deneyim sunar.

Manuel Etiketleme: Tüm içerikler (slayt, çıkmış soru, A+ notu) "Ders", "Tür", "Konu", "Yıl" gibi kritik etiketlerle manuel olarak zenginleştirilir.

Platform İçi Görüntüleyici (İndirme Yasağı!): Tüm PDF ve Resim dosyaları sadece uygulama içinde açılır. İçeriğin platform dışına çıkması (indirilmesi) engellenir. Bu, projenin ekonomik temelidir.

Topluluk ve Oyunlaştırma Motoru:

İçerik Yükleme: Kullanıcıların kendi PDF/JPEG dosyalarını (sıkı format kontrolü ile) yüklemesine izin verilir.

Oylama (Upvote/Downvote): "En iyi" notun veya "en faydalı" çıkmış sorunun en üste çıkmasını sağlayan ana mekanizma.

Yorumlar: Her içeriğin altında tartışma ve soru-cevap alanı.

Profil & Statü: En çok katkı sağlayan (A+ notunu paylaşan) kullanıcılar "kahraman" olarak öne çıkarılır.

Sosyal Etkileşim:

Her dersin/içeriğin altında "Bu derse/sınava birlikte çalışacak birini bul" alanı.

Gelecek Vizyonu (15 Milyon TL'lik Yol)
AI Premium Asistan (B2C):

Yüklenen notları ve slaytları anlayan bir AI asistanı.

"Bu 50 sayfalık slaytı 5 sayfaya özetle."

"Bu çıkmış sorulardan bana 10 soruluk bir test hazırla."

Hoca Modülü (B2B):

Hocaların ödevleri platform üzerinden toplaması.

AI'ın o ödevleri özetlemesi veya intihal kontrolü yapması.

Kariyer Köprüsü (B2B):

Platformdaki "en yüksek" oylu notların sahiplerini (doğrulanmış yetenekleri) şirketlerle buluşturan bir işe alım modülü.

🏛️ Mimari Felsefesi (Proje Anayasası)
Bu projenin başarısı, aşağıda belirtilen 4 "acımasız" felsefeye bağlıdır. Bu kurallar asla ihlal edilmemelidir.

Felsefe 1: Angarya, Bizim Değerimizdir.

Açıklama: Rakiplerimizin "uğraşmaya değmez" dediği "angarya" (manuel işçilik), bizim en büyük değerimizdir. O "cold start" (ilk yükleme) angaryası, o "manuel etiketleme" angaryası ve o "A+ notu dilenciliği" angaryası, pazara giriş bariyerimizdir. Bu işi yapmak zorundayız.

Kural: "Bunu nasıl otomatize ederim?" diye sormadan önce, "Bunu manuel olarak mükemmel bir şekilde nasıl yaparım?" diye sor.

Felsefe 2: Önce Kale, Sonra Dünya (Hiper-Odaklanma).

Açıklama: "Herkes" için bir uygulama yapmaya çalışmak, hiç kimse için bir uygulama yapamamaktır. O "Aktivasyon" ve "Gürültü" duvarlarını aşmanın tek yolu, tek bir kaleyi (örn: Erciyes Yazılım Bölümü) mükemmel bir şekilde fethetmektir.

Kural: O ilk kaleyi (niş pazarı) domine etmeden asla yeni bir üniversiteye, bölüme veya sınıfa "saldırma".

Felsefe 3: İçerik = Platform (İndirme Yasağı!).

Açıklama: Kullanıcı notu indirirse, platforma olan ihtiyacı biter. Uygulamayı siler. AI Asistanı kullanamaz. Oylama yapamaz. Para kazanamayız.

Kural: İçerik asla indirilemez. Sadece platform içi görüntüleyici (PDF/Image Viewer) ile erişilebilir. Biz bir "kütüphane" değil, bir "platform" kuruyoruz.

Felsefe 4: Yükü Sunucuya Değil, Kullanıcıya Ver.

Açıklama: "Word, PPTX, HEIC formatlarını çevirelim" fikri, bizi bizim işimiz olmayan (ve çok pahalı olan) bir teknik bataklığa sürükler.

Kural: MVP (İlk Ürün) SADECE PDF ve JPEG/PNG kabul eder. Kullanıcı .docx mi yüklemek istiyor? Ona "Hata: Lütfen önce PDF'e çevirip yükleyin" diyen bir mesaj göster. O "dönüştürme" angaryasını kullanıcı (veya cold start yaparken sen) üstlenmeli, sunucu değil.

📁 Backend (FastAPI) Dosya Yapısı
Backend, temiz kod, test edilebilirlik ve ölçeklenebilirlik için tasarlanmış modüler bir FastAPI yapısı kullanır.

/backend
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
├── /alembic              # Alembic veritabanı "migration" (taşıma) dosyaları
├── /tests                # Kodun çalıştığını doğrulayan testler
├── .env                  # Veritabanı şifresi, API anahtarları gibi GİZLİ bilgiler (Git'e EKLENMEMELİ)
├── .env.example          # .env dosyasının nasıl görünmesi gerektiğine dair şablon
├── .gitignore            
├── alembic.ini           # Alembic ayar dosyası
└── requirements.txt      # Gerekli Python kütüphaneleri (fastapi, uvicorn, sqlalchemy, PyMySQL...)
📂 Frontend (React) Dosya Yapısı
Frontend, "feature-based" (özellik tabanlı) ve "component-based" (bileşen tabanlı) modern bir React (Vite ile) yapısı kullanır.

/frontend
├── /public                 # Doğrudan erişilen statik dosyalar (örn: favicon)
├── /src                    # Asıl React uygulama kodu
│   ├── /api                # Backend ile konuşan tüm fonksiyonlar
│   │   ├── apiClient.js    # Ana 'axios' ayarları (Backend URL'si, Token'ı header'a ekleme)
│   │   ├── authService.js  # (login(), register() API istekleri)
│   │   └── contentService.js # (uploadContent(), getContentByCourse() API istekleri)
│   │
│   ├── /assets             # Kod içine 'import' edilen resimler, fontlar, CSS/SCSS
│   ├── /components         # Tekrar kullanılabilen "aptal" UI parçaları
│   │   ├── /common         # Proje geneli (Button, Input, Modal, Spinner)
│   │   ├── /layout         # Sayfa iskeleti (Navbar, Sidebar, Footer)
│   │   └── /content        # İçerik özelindeki bileşenler
│   │       ├── ContentCard.jsx     # Liste sayfasındaki tek bir not kartı
│   │       ├── PdfViewer.jsx       # 'İndirme yasağı' stratejisi için kritik PDF gösterici
│   │       └── UploadForm.jsx      # 'Angarya' manuel etiketleme formu
│   │
│   ├── /contexts           # Global (genel) 'State' yönetimi
│   │   └── AuthContext.jsx   # Kullanıcının giriş yapıp yapmadığı bilgisini tüm uygulamada saklar
│   │
│   ├── /hooks              # Tekrar kullanılabilen 'Logic' (mantık) parçaları
│   ├── /pages              # URL'lere karşılık gelen tam sayfa bileşenleri
│   │   ├── HomePage.jsx          # Ana sayfa (Ders listesi)
│   │   ├── LoginPage.jsx         # Giriş formu sayfası
│   │   ├── CourseDetailPage.jsx  # Bir dersin tüm notlarının/slaytlarının listelendiği sayfa
│   │   ├── ContentDetailPage.jsx # Tek bir notun/PDF'in 'PdfViewer' ile açıldığı sayfa
│   │   └── ManualUploadPage.jsx  # Senin 'cold start' angaryası için kullanacağın admin yükleme ekranı
│   │
│   ├── App.jsx             # Ana 'Router' (React Router Dom) - Hangi URL'in hangi 'page'i göstereceğini belirler
│   └── main.jsx            # React uygulamasını HTML'e bağlayan başlangıç dosyası
│
├── .env                    # (VITE_API_BASE_URL gibi) GİZLİ olmayan ayarlar
├── .gitignore
├── package.json            # Gerekli JavaScript kütüphaneleri (react, react-dom, axios, react-router-dom...)
└── vite.config.js          # Vite için proje ayar dosyası