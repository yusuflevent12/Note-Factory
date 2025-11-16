import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { getContentDetails, voteOnContent } from '../api/contentService';
import Navbar from '../components/layout/Navbar';
import Footer from '../components/layout/Footer';
import PdfViewer from '../components/content/PdfViewer';
import Spinner from '../components/common/Spinner';
import Button from '../components/common/Button';

/**
 * Tek bir ders materyalinin (PDF, resim vb.) detaylarının görüntülendiği sayfa.
 */
const ContentDetailPage = () => {
  const { contentId } = useParams();
  const [content, setContent] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  const fetchContentDetails = async () => {
    try {
      setLoading(true);
      setError('');
      const data = await getContentDetails(contentId);
      setContent(data);
    } catch (err) {
      setError('İçerik detayları yüklenirken bir sorun oluştu.');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchContentDetails();
  }, [contentId]);

  const handleVote = async (voteType) => {
    try {
      // Oylama sonrası arayüzü anında güncellemek için optimistic bir yaklaşım benimsenebilir,
      // veya sunucudan dönen güncel veriyle state'i tekrar set edebiliriz.
      const updatedContent = await voteOnContent(contentId, voteType);
      setContent(updatedContent);
    } catch (err) {
      alert(`Oylama sırasında hata oluştu: ${err.detail || err.message}`);
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <Spinner text="İçerik yükleniyor..." />
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <p className="text-red-500">{error}</p>
      </div>
    );
  }

  if (!content) {
    return null; // Veya "İçerik bulunamadı" mesajı
  }

  const voteScore = content.upvotes - content.downvotes;

  return (
    <div className="flex flex-col min-h-screen bg-gray-100">
      <Navbar />
      <main className="flex-1 container mx-auto p-4 md:p-8">
        <div className="bg-white p-6 rounded-lg shadow-lg">
          {/* Başlık ve Meta Bilgiler */}
          <h1 className="text-3xl font-bold text-gray-900">{content.title}</h1>
          <p className="text-md text-gray-600 mt-2">{content.description}</p>
          <div className="flex items-center justify-between mt-4 border-t border-b py-2">
            <p className="text-sm text-gray-500">
              Yükleyen: {content.author?.full_name || 'Bilinmiyor'}
            </p>
            <div className="flex items-center space-x-4">
              <Button onClick={() => handleVote('upvote')} variant="secondary">👍 ({content.upvotes})</Button>
              <span className="text-lg font-bold">{voteScore}</span>
              <Button onClick={() => handleVote('downvote')} variant="secondary">👎 ({content.downvotes})</Button>
            </div>
          </div>

          {/* İçerik Görüntüleyici */}
          <div className="mt-6">
            {content.file_url && (content.file_url.endsWith('.pdf') || content.file_url.startsWith('data:application/pdf')) ? (
              <PdfViewer fileUrl={content.file_url} />
            ) : content.file_url ? (
              <img src={content.file_url} alt={content.title} className="max-w-full h-auto rounded-md border" />
            ) : (
              <p>Görüntülenecek dosya bulunamadı.</p>
            )}
          </div>

          {/* Yorumlar Bölümü (Gelecekte Eklenecek) */}
          <div className="mt-8">
            <h2 className="text-2xl font-bold">Yorumlar</h2>
            <div className="mt-4 p-4 bg-gray-50 rounded-md">
              <p className="text-gray-500">Yorumlar özelliği yakında eklenecektir.</p>
            </div>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
};

export default ContentDetailPage;
