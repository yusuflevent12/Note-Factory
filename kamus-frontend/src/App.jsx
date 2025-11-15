import React from 'react';
import { Routes, Route } from 'react-router-dom';

// Sayfaları (Pages) import et
import HomePage from './pages/HomePage';
import LoginPage from './pages/LoginPage';
import CourseDetailPage from './pages/CourseDetailPage';
import ContentDetailPage from './pages/ContentDetailPage';
import ManualUploadPage from './pages/ManualUploadPage';

// Yerleşimi (Layout) import et
import Navbar from './components/layout/Navbar';
import Footer from './components/layout/Footer';

// Hiçbir sayfa bulunamadığında gösterilecek basit bir 404 "angarya" bileşeni
function NotFound() {
  return <h1 style={{ textAlign: 'center' }}>404: Sayfa Bulunamadı (Angarya)</h1>;
}

function App() {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}>
      <Navbar />
      <main style={{ flex: 1, padding: '20px' }}>
        <Routes>
          {/* Ana rotalar (Senin kodun - Zaten doğruydu) */}
          <Route path="/" element={<h1>MERHABA DÜNYA (Ana Sayfa)</h1>} />
          <Route path="/login" element={<LoginPage />} />
          <Route path="/course/:courseId" element={<CourseDetailPage />} />
          <Route path="/content/:contentId" element={<ContentDetailPage />} />
          <Route path="/upload" element={<ManualUploadPage />} />
          
          {/* KRİTİK "ANGARYA" DÜZELTMESİ: */}
          {/* Hiçbir yol eşleşmezse (404), 'NotFound' bileşenini göster */}
          <Route path="*" element={<NotFound />} />
        </Routes>
      </main>
      <Footer />
    </div>
  );
}

export default App;