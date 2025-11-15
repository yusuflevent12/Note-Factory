import React from 'react';
import { Routes, Route } from 'react-router-dom';
import HomePage from './pages/HomePage';
import LoginPage from './pages/LoginPage';
import CourseDetailPage from './pages/CourseDetailPage';
import ContentDetailPage from './pages/ContentDetailPage';
import ManualUploadPage from './pages/ManualUploadPage';
import Navbar from './components/layout/Navbar';
import Footer from './components/layout/Footer';

function App() {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}>
      <Navbar />
      <main style={{ flex: 1, padding: '20px' }}>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/login" element={<LoginPage />} />
          <Route path="/course/:courseId" element={<CourseDetailPage />} />
          <Route path="/content/:contentId" element={<ContentDetailPage />} />
          <Route path="/upload" element={<ManualUploadPage />} />
        </Routes>
      </main>
      <Footer />
    </div>
  );
}

export default App;
