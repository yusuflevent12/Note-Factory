import React from 'react';
import ContentCard from '../../components/content/ContentCard';
import Sidebar from '../../components/layout/Sidebar';

const HomePage = () => {
  const mockContent = [
    { id: 1, title: 'Yazılım Müh. - Vize Soruları', description: '2023 yılı vize soruları ve çözümleri.' },
    { id: 2, title: 'Veri Yapıları - Ders Notları', description: 'Prof. Dr. Ahmet Yılmaz\'ın ders notları.' },
    { id: 3, title: 'Algoritmalar - Final Projesi', description: 'Final projesi örnekleri ve açıklamaları.' },
  ];

  return (
    <div style={{ display: 'flex' }}>
      <Sidebar />
      <div style={{ flex: 1, paddingLeft: '20px' }}>
        <h2>Hoş Geldiniz!</h2>
        <p>Aşağıdaki ders notlarına göz atabilirsiniz.</p>
        <div>
          {mockContent.map(content => (
            <ContentCard key={content.id} title={content.title} description={content.description} />
          ))}
        </div>
      </div>
    </div>
  );
};

export default HomePage;
