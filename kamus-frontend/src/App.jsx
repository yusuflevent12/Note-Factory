import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';

// Sayfaları import et
import HomePage from './pages/HomePage';
import LoginPage from './pages/LoginPage';
import CourseDetailPage from './pages/CourseDetailPage';
import ContentDetailPage from './pages/ContentDetailPage';
import ManualUploadPage from './pages/ManualUploadPage';
import ProtectedRoute from './components/common/ProtectedRoute';

// Hiçbir sayfa bulunamadığında gösterilecek basit bir 404 bileşeni
function NotFound() {
  return (
    <div className="text-center py-20">
      <h1 className="text-4xl font-bold">404</h1>
      <p className="text-xl text-gray-600">Sayfa Bulunamadı</p>
    </div>
  );
}

function App() {
  return (
    <Router>
      <Routes>
        {/* Herkesin erişebileceği rotalar */}
        <Route path="/" element={<HomePage />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/course/:courseId" element={<CourseDetailPage />} />
        <Route path="/content/:contentId" element={<ContentDetailPage />} />

        {/* Sadece giriş yapmış kullanıcıların erişebileceği korumalı rotalar */}
        <Route element={<ProtectedRoute />}>
          <Route path="/upload" element={<ManualUploadPage />} />
          {/* Gelecekte eklenecek diğer korumalı sayfalar buraya gelebilir, örn: /profile */}
        </Route>

        {/* Hiçbir yol eşleşmezse (404) gösterilecek rota */}
        <Route path="*" element={<NotFound />} />
      </Routes>
    </Router>
  );
}

export default App;
