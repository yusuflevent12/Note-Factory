Proje: Kampüs Çekirdeği (NoteFactory)

Kampüs Çekirdeği, üniversite öğrencilerinin ders içeriklerine (slayt, çıkmış soru, not) tek bir yerden, organize bir şekilde erişmesini sağlayan ve bu içerikler etrafında bir topluluk oluşturmayı hedefleyen Cross-Platform (iOS/Android) Mobil Uygulama projesidir.

🚀 Projenin Misyonu ve Çözdüğü Sorun

Üniversite öğrencilerinin en büyük zorluğu ders materyallerini bulmaktır. Mevcut içerik; dağınık (WhatsApp, Google Drive), eksik ("hocanın slaytı yok", "kimse not tutmuyor"), kategorize edilmemiş ("bu vize mi final mi?") ve kalitesizdir.

Kampüs Çekirdeği bu sorunu şu şekilde çözer:

Manuel ve Odaklı Başlangıç: Platform, kurucular tarafından manuel olarak yüklenen, "hiper-odaklı" (örn: Erciyes Üni. Yazılım Bölümü) ve etiketlenmiş bir çekirdek içerik (slayt, çıkmış soru) ile başlar.

Topluluk Motoru: Kullanıcıların (öğrencilerin) kendi içeriklerini yüklemesini, oylamasını ve tartışmasını sağlayarak platformun kendi kendini büyütmesini sağlar.

AI Destek: Gelecekte, bu içerikleri "akıllı" hale getirerek (özetleme, test hazırlama) pasif bir kütüphaneden aktif bir asistana dönüşür.

🎯 Temel Özellikler (MVP & Vizyon)

MVP (Minimum Uygulanabilir Ürün) Özellikleri

Hiper-Odaklı İçerik Kütüphanesi:

Hiper-Odaklı Başlangıç: Sadece belirli bir niş'e (örn: Erciyes Üni. Yazılım Bölümü) odaklanmış, "rafları dolu" bir deneyim sunar.

Manuel Etiketleme: Tüm içerikler (slayt, çıkmış soru, A+ notu) "Ders", "Tür", "Konu", "Yıl" gibi kritik etiketlerle manuel olarak zenginleştirilir.

Platform İçi Görüntüleyici (İndirme Yasağı!): Tüm PDF ve Resim dosyaları sadece uygulama içinde (native PDF/Image viewer) açılır. İçeriğin platform dışına çıkması (indirilmesi) engellenir.

Topluluk ve Oyunlaştırma Motoru:

İçerik Yükleme: Kullanıcıların kendi PDF/JPEG dosyalarını (sıkı format kontrolü ile) yüklemesine izin verilir.

Oylama (Upvote/Downvote): "En iyi" notun veya "en faydalı" çıkmış sorunun en üste çıkmasını sağlayan ana mekanizma.

Yorumlar: Her içeriğin altında tartışma ve soru-cevap alanı.

Profil & Statü: En çok katkı sağlayan (A+ notunu paylaşan) kullanıcılar "kahraman" olarak öne çıkarılır.

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

Felsefe 1: Manuel ve Odaklı Başlangıç Değerimizdir.

Açıklama: Rakiplerimizin "uğraşmaya değmez" dediği "manuel işçilik", bizim en büyük değerimizdir. O "cold start" (ilk yükleme) süreci, o "manuel etiketleme" zorluğu ve o "A+ notu dilenciliği" (ikna süreci), pazara giriş bariyerimizdir. Bu işi yapmak zorundayız.

Kural: "Bunu nasıl otomatize ederim?" diye sormadan önce, "Bunu manuel olarak mükemmel bir şekilde nasıl yaparım?" diye sor.

Felsefe 2: Önce Kale, Sonra Dünya (Hiper-Odaklanma).

Açıklama: "Herkes" için bir uygulama yapmaya çalışmak, hiç kimse için bir uygulama yapamamaktır. "Aktivasyon" ve "Gürültü" duvarlarını aşmanın tek yolu, tek bir kaleyi (örn: Erciyes Yazılım Bölümü) mükemmel bir şekilde fethetmektir.

Kural: O ilk kaleyi (niş pazarı) domine etmeden asla yeni bir üniversiteye, bölüme veya sınıfa "saldırma".

Felsefe 3: İçerik = Platform (İndirme Yasağı!).

Açıklama: Kullanıcı notu indirirse, platforma olan ihtiyacı biter. Uygulamayı siler. AI Asistanı kullanamaz. Oylama yapamaz. Para kazanamayız.

Kural: İçerik asla indirilemez. Sadece platform içi (native) görüntüleyici ile erişilebilir. Biz bir "kütüphane" değil, bir "platform" kuruyoruz.

Felsefe 4: Yükü Sunucuya Değil, Kullanıcıya Ver.

Açıklama: "Word, PPTX, HEIC formatlarını çevirelim" fikri, bizi bizim işimiz olmayan (ve çok pahalı olan) bir teknik bataklığa sürükler.

Kural: MVP (İlk Ürün) SADECE PDF ve JPEG/PNG kabul eder. Kullanıcı .docx mi yüklemek istiyor? Ona "Hata: Lütfen önce PDF'e çevirip yükleyin" diyen bir mesaj göster. O "dönüştürme" işini kullanıcı (veya cold start yaparken sen) üstlenmeli, sunucu değil.

🚀 Mimari ve Teknoloji Yığını

Proje, iki ana bileşenden oluşan bir "Monorepo" (Tek Depo) içinde yönetilir: backend (Mutfak) ve frontend_mobil (Garson).

1. Backend (FastAPI) Teknolojileri (AYNI KALDI)

Backend, Python tabanlı FastAPI çerçevesini kullanır.

Çerçeve (Framework): FastAPI

Veritabanı (Database): MariaDB (MySQL Diyalekti)

ORM (Veritabanı Köprüsü): SQLAlchemy

Migrasyon (Tablo Yaratma): Alembic

Veri Doğrulama (Schemas): Pydantic

Sunucu (Server): Uvicorn

Kimlik Doğrulama (Auth): JWT (python-jose) ve Passlib (bcrypt)

Sürücü (Driver): PyMySQL

2. Frontend (Flutter) Teknolojileri (YENİ)

Frontend, web (React) yerine, tek bir Dart kod tabanıyla hem iOS hem de Android için native (gerçek) mobil uygulama üreten Flutter çerçevesini kullanır.

Çerçeve (Framework): Flutter

Dil (Language): Dart

Durum Yönetimi (State Management): Riverpod (Ölçeklenebilir ve modern durum yönetimi için)

Yönlendirme (Routing): GoRouter (Modern, URL tabanlı sayfa geçişleri için)

API İstemcisi (HTTP Client): Dio (Backend [FastAPI] ile konuşmak için güçlü istemci)

Yerel Depolama (Storage): shared_preferences (Kullanıcının giriş (login) token'ını saklamak için)

PDF Görüntüleyici (Viewer): flutter_pdfview (Felsefe 3 - "İndirme Yasağı" için kritik)

📁 Backend (FastAPI) Dosya Yapısı (AYNI KALDI)

Backend, temiz kod, test edilebilirlik ve ölçeklenebilirlik için tasarlanmış modüler bir FastAPI yapısı kullanır.

/backend
├── /app                  # Ana Python paketi
│   ├── /api              # API endpoint (URL) yönetimi
│   │   ├── /v1           # API'nin 1. versiyonu
│   │   │   ├── api_router.py
│   │   │   └── /endpoints
│   │   │       ├── auth.py
│   │   │       ├── hierarchy.py
│   │   │       └── content.py
│   ├── /core             # Ayarlar (config.py, security.py)
│   ├── /db               # Veritabanı bağlantı (session.py, base.py)
│   ├── /models           # Veritabanı Tabloları (user.py, content.py...)
│   ├── /schemas          # API Veri Kuralları (user.py, content.py...)
│   ├── /services         # Asıl İş Mantığı
│   └── main.py           # FastAPI uygulamasını başlatan ana dosya
├── /migrations           # Alembic veritabanı "migration" (taşıma) dosyaları
├── .env                  # GİZLİ bilgiler (Git'e EKLENMEMELİ)
├── .env.example
├── .gitignore
├── alembic.ini           # Alembic ayar dosyası
└── requirements.txt      # Gerekli Python kütüphaneleri


📂 Frontend (Flutter) Dosya Yapısı (YENİ)

Frontend, React/Vite yapısını tamamen terk eder ve ölçeklenebilir bir Flutter/Dart mimarisini kullanır. Tüm kod lib klasöründe yaşar.

/frontend_mobil
├── /lib                    # Asıl Dart uygulama kodu
│   ├── /src
│   │   ├── /api (veya /services) # Backend ile konuşan kodlar
│   │   │   ├── dio_client.dart     # Ana 'Dio' istemci ayarları (BaseURL, Token)
│   │   │   ├── auth_service.dart   # login(), register() API istekleri
│   │   │   ├── hierarchy_service.dart # getUniversities(), getCourses()
│   │   │   └── content_service.dart   # getContentForCourse()
│   │
│   │   ├── /models           # JSON verisini Dart objelerine çeviren sınıflar
│   │   │   ├── course_model.dart
│   │   │   ├── content_model.dart
│   │   │   └── user_model.dart
│   │
│   │   ├── /providers        # Riverpod State Management (Uygulama hafızası)
│   │   │   ├── auth_provider.dart  # Kullanıcının giriş yapıp yapmadığını saklar
│   │   │   └── async_providers.dart # API'den gelen 'ders' veya 'içerik' listesini saklar
│   │
│   │   ├── /screens          # Tam sayfa görünümleri
│   │   │   ├── home_screen.dart    # Ana Sayfa (Derslerin listesi)
│   │   │   ├── login_screen.dart
│   │   │   ├── register_screen.dart
│   │   │   ├── course_detail_screen.dart # Bir dersin içeriğini (notlar) listeleyen sayfa
│   │   │   └── content_view_screen.dart  # PDF Görüntüleyicinin (PdfViewer) olduğu son sayfa
│   │
│   │   ├── /widgets          # Tekrar kullanılabilen "aptal" UI parçaları
│   │   │   ├── /common       # Proje geneli (CustomButton, LoadingSpinner)
│   │   │   └── content_card.dart # Ders detay sayfasındaki tek bir not kartı
│   │
│   │   ├── /core (veya /utils)
│   │   │   ├── app_router.dart   # GoRouter (Trafik Polisi) ayarları
│   │   │   └── constants.dart    # API Adresi ([http://10.0.2.2:8000](http://10.0.2.2:8000)), Renkler
│   │
│   └── main.dart             # Flutter uygulamasını başlatan ana dosya
│
├── /assets                   # Resimler (logo.png), Fontlar
├── android                   # Android'e özel proje dosyaları (Otomatik oluşur)
├── ios                     # iOS'a özel proje dosyaları (Otomatik oluşur)
├── .gitignore
└── pubspec.yaml              # Gerekli Dart/Flutter kütüphaneleri (dio, riverpod, go_router...)


📱 Uygulama Akışı (Ekran Tasarımı)

Kullanıcı uygulamayı açtığında göreceği ve etkileşime gireceği temel ekranlar:

Giriş Ekranı (login_screen.dart):

Görünüm: Uygulama logosu, "E-posta" ve "Şifre" için metin kutuları (TextFormField), "Giriş Yap" butonu (Button).

Tuş: "Giriş Yap" tuşuna basıldığında auth_service.dart'ı çağırır, Backend'e (/api/v1/auth/login) bağlanır.

Link: "Hesabın yok mu? Kayıt Ol" linki, register_screen.dart'a yönlendirir.

Ana Sayfa (home_screen.dart):

Görünüm: Üstte bir Başlık Çubuğu (AppBar) - Başlık: "Erciyes Yazılım". Altında dikey, kaydırılabilir bir liste (ListView.builder).

Butonlar (Kartlar): Listenin her elemanı bir "Ders Kartı"dır (örn: [YZM-201] - Veri Yapıları). Bu kartlar birer tuştur.

Ders Detay Ekranı (course_detail_screen.dart):

Görünüm: Kullanıcı "Veri Yapıları" tuşuna (kartına) tıkladığında bu ekran açılır.

Başlık: "Veri Yapıları".

Ana İçerik: O derse ait tüm içeriklerin (Slayt, Not, Çıkmış Soru) listesi (ListView).

Tuşlar (İçerik Kartları - content_card.dart): Her kart bir tuştur. Üzerinde [SLAYT] - Hafta 3 Özeti yazar. Sağ köşesinde ▲ 15 (Upvote sayısı) görünür.

İçerik Görüntüleme Ekranı (content_view_screen.dart):

Görünüm: Kullanıcı "Hafta 3 Özeti" tuşuna tıkladığında bu ekran açılır.

Ana İçerik: Ekranın %90'ını kaplayan PDF Görüntüleyici (PdfViewer). Kullanıcı PDF'i burada okur (İndirme Yasağı!).

Tuşlar: Ekranın altında (veya üstünde) "Beğen" (Upvote), "Beğenme" (Downvote) tuşları ve "Yorumlar" bölümü.

(Bonus) Yükleme Tuşu:

Ana Sayfada (home_screen.dart) sağ altta, yüzen bir + tuşu (Floating Action Button).

Tuş: Tıklandığında "İçerik Yükle" ekranını açar. Bu ekranda "Ders Seç" (Dropdown), "Tür Seç" (Dropdown) ve "Dosya Yükle" tuşları bulunur.