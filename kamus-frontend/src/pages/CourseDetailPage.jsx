import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { getContentByCourse } from '../api/contentService';
import Navbar from '../components/layout/Navbar';
import Sidebar from '../components/layout/Sidebar';
import Footer from '../components/layout/Footer';
import ContentCard from '../components/content/ContentCard';
import Spinner from '../components/common/Spinner';

/**
 * Belirli bir derse/bölüme ait tüm içeriklerin listelendiği sayfa.
 */
const CourseDetailPage = () => {
  const { courseId } = useParams(); // URL'den dinamik 'courseId' parametresini alıyoruz.
  const [contentList, setContentList] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [courseName, setCourseName] = useState('Ders Detayları'); // Bu bilgi de API'den gelmeli.

  useEffect(() => {
    const fetchContent = async () => {
      try {
        setLoading(true);
        setError('');
        const data = await getContentByCourse(courseId);
        setContentList(data);
        // Gerçek bir uygulamada, dersin adını da getiren ayrı bir API çağrısı olabilir.
        // Şimdilik URL'deki ID'yi kullanarak basit bir başlık oluşturuyoruz.
        if (data.length > 0) {
            // Örnek olarak ilk içeriğin ders adını kullanabiliriz veya bu bilgi başka bir endpoint'ten gelir.
            // setCourseName(data[0].course.name);
        } else {
            // setCourseName(`Bölüm ${courseId} Dersleri`);
        }
      } catch (err) {
        setError('İçerikler yüklenirken bir sorun oluştu.');
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchContent();
  }, [courseId]); // courseId değiştiğinde useEffect'in tekrar çalışmasını sağlıyoruz.

  return (
    <div className="flex flex-col min-h-screen bg-gray-50">
      <Navbar />
      <div className="flex flex-1">
        <Sidebar />
        <main className="flex-1 p-8">
          <h1 className="text-3xl font-bold text-gray-800 mb-6">{courseName}</h1>

          {loading && <Spinner text="İçerikler yükleniyor..." />}

          {error && <p className="text-red-500">{error}</p>}

          {!loading && !error && (
            contentList.length > 0 ? (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {contentList.map((content) => (
                  <ContentCard key={content.id} content={content} />
                ))}
              </div>
            ) : (
              <div className="text-center py-10 bg-white rounded-lg shadow-md">
                <p className="text-gray-600">Bu ders için henüz içerik yüklenmemiş.</p>
              </div>
            )
          )}
        </main>
      </div>
      <Footer />
    </div>
  );
};

export default CourseDetailPage;
