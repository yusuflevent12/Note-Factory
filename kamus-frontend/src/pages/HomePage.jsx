import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import apiClient from '../api/apiClient'; // O 'frontend/src/api/apiClient.js' dosyamız

function HomePage() {
  // 1. Dersleri saklamak için "state" (hafıza) oluştur
  const [courses, setCourses] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // 2. "Hiper-Odaklanma" Felsefesi:
  // Sadece "Yazılım Mühendisliği" bölümünün derslerini çekeceğiz.
  // Veritabanına manuel eklerken ID'sinin '1' olduğunu varsayıyorum.
  const HYPER_FOCUS_DEPARTMENT_ID = 1;

  // 3. Bu bileşen (sayfa) yüklendiğinde SADECE BİR KEZ çalışacak "useEffect"
  useEffect(() => {
    
    // Veri çekme fonksiyonu
    const fetchCourses = async () => {
      try {
        setLoading(true);
        setError(null);
        
        // 4. Backend'deki O ENDPOINT'İ ÇAĞIR:
        // (GET /api/v1/courses/{department_id})
        const response = await apiClient.get(
          `/api/v1/courses/${HYPER_FOCUS_DEPARTMENT_ID}`
        );
        
        // 5. Gelen veriyi (ders listesini) "state"e (hafızaya) kaydet
        setCourses(response.data);

      } catch (err) {
        console.error("Backend'den veri çekerken hata:", err);
        setError("Dersler yüklenemedi. Backend (uvicorn) sunucunuzun çalıştığından emin olun.");
      } finally {
        setLoading(false);
      }
    };

    fetchCourses(); // Fonksiyonu çalıştır
    
  }, []); // [] = "Sadece bir kez çalıştır"

  // 6. Yükleme (Loading) ekranı
  if (loading) {
    return <div style={{ textAlign: 'center', marginTop: '50px' }}>Yükleniyor...</div>;
  }

  // 7. Hata ekranı
  if (error) {
    return <div style={{ textAlign: 'center', color: 'red', marginTop: '50px' }}>{error}</div>;
  }

  // 8. Zafer Anı: Dersleri Ekrana Basma
  return (
    <div>
      <h1 style={{ borderBottom: '2px solid #eee', paddingBottom: '10px' }}>
        Yazılım Mühendisliği Dersleri
      </h1>
      
      {/* Veritabanından gelen dersleri listele */}
      {courses.length === 0 ? (
        <p>Veritabanında hiç ders bulunamadı. (HeidiSQL/DBeaver'dan 'courses' tablosunu kontrol et)</p>
      ) : (
        <ul style={{ listStyle: 'none', padding: 0 }}>
          {courses.map(course => (
            <li key={course.id} style={{ padding: '15px', border: '1px solid #ddd', marginBottom: '10px', borderRadius: '5px' }}>
              {/* App.jsx'te tanımladığımız '/course/:courseId' rotasına link ver */}
              <Link 
                to={`/course/${course.id}`} 
                style={{ textDecoration: 'none', color: '#007bff', fontSize: '1.2rem', fontWeight: 'bold' }}
              >
                {course.course_code} - {course.name}
              </Link>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

export default HomePage;