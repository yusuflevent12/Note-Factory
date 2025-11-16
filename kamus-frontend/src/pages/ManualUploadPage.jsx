import React from 'react';
import { useNavigate } from 'react-router-dom';
import Navbar from '../components/layout/Navbar';
import Footer from '../components/layout/Footer';
import UploadForm from '../components/content/UploadForm';

/**
 * Yöneticilerin veya kurucuların "cold start" (ilk yükleme) işlemini yapabileceği,
 * manuel içerik yükleme formu sayfası.
 */
const ManualUploadPage = () => {
  const navigate = useNavigate();

  // Yükleme başarılı olduğunda kullanıcıyı bilgilendirip, belki de yüklenen içeriğin
  // listelendiği sayfaya yönlendirebiliriz.
  const handleUploadSuccess = (uploadedContent) => {
    alert(`'${uploadedContent.title}' başlıklı içerik başarıyla yüklendi!`);
    // Şimdilik ana sayfaya yönlendiriyoruz.
    // navigate(`/course/${uploadedContent.course_id}`);
    navigate('/');
  };

  return (
    <div className="flex flex-col min-h-screen bg-gray-100">
      <Navbar />
      <main className="flex-1 container mx-auto p-4 md:p-8">
        <div className="max-w-2xl mx-auto">
          <div className="bg-white p-6 rounded-lg shadow-lg">
            <h1 className="text-2xl font-bold text-gray-800 mb-4">Manuel İçerik Yükleme</h1>
            <p className="text-sm text-gray-600 mb-6">
              Bu arayüz, platforma ilk içerikleri ("cold start") eklemek için kullanılır.
              Lütfen tüm alanları dikkatlice doldurun.
            </p>
            <UploadForm onUploadSuccess={handleUploadSuccess} />
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
};

export default ManualUploadPage;
