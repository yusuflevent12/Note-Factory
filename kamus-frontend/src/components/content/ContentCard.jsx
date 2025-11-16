import React from 'react';
import { Link } from 'react-router-dom';

/**
 * Bir ders materyalini (not, slayt, çıkmış soru) liste sayfalarında göstermek için kullanılan kart bileşeni.
 * @param {object} props - Bileşenin aldığı proplar.
 * @param {object} props.content - Kartta gösterilecek içerik nesnesi.
 *   Örnek `content` nesnesi:
 *   {
 *     id: 1,
 *     title: 'Kalkülüs Vize Soruları',
 *     content_type: 'exam', // 'note', 'slide' etc.
 *     author: { full_name: 'Ayşe Yılmaz' },
 *     upvotes: 15,
 *     downvotes: 2,
 *     comment_count: 5,
 *   }
 */
const ContentCard = ({ content }) => {
  // İçerik türüne göre bir ikon veya etiket gösterilebilir.
  const getContentTypeLabel = (type) => {
    switch (type) {
      case 'exam':
        return 'Çıkmış Soru';
      case 'note':
        return 'Ders Notu';
      case 'slide':
        return 'Slayt';
      default:
        return 'İçerik';
    }
  };

  const voteScore = content.upvotes - content.downvotes;

  return (
    <Link
      to={`/content/${content.id}`}
      className="block bg-white p-4 rounded-lg shadow-md hover:shadow-lg transition-shadow duration-200 border border-gray-200"
    >
      <div className="flex justify-between items-start">
        <div>
          <span className="text-xs font-semibold bg-blue-100 text-blue-800 px-2 py-1 rounded-full">
            {getContentTypeLabel(content.content_type)}
          </span>
          <h3 className="text-lg font-bold text-gray-800 mt-2">{content.title}</h3>
          <p className="text-sm text-gray-600 mt-1">
            Yükleyen: {content.author?.full_name || 'Bilinmiyor'}
          </p>
        </div>
        <div className="flex flex-col items-center">
          <span className="text-xl font-bold text-green-600">{voteScore}</span>
          <span className="text-xs text-gray-500">Puan</span>
        </div>
      </div>
      <div className="mt-4 pt-4 border-t border-gray-200 flex justify-between text-sm text-gray-500">
        <span>{content.comment_count || 0} Yorum</span>
        {/* Başka meta veriler (tarih vb.) buraya eklenebilir */}
      </div>
    </Link>
  );
};

export default ContentCard;
