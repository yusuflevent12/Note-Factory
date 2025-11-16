import React, { useState } from 'react';
import { useAuth } from '../../contexts/AuthContext';
import { uploadContent } from '../../api/contentService';
import Input from '../common/Input';
import Button from '../common/Button';
import Spinner from '../common/Spinner';

/**
 * Kullanıcıların veya yöneticilerin yeni ders materyali (not, slayt vb.) yüklemesini sağlayan form bileşeni.
 * @param {object} props - Bileşenin aldığı proplar.
 * @param {function} props.onUploadSuccess - Yükleme başarılı olduğunda çağrılacak fonksiyon.
 */
const UploadForm = ({ onUploadSuccess }) => {
  const { isAuthenticated } = useAuth();
  const [file, setFile] = useState(null);
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');
  const [contentType, setContentType] = useState('note'); // Varsayılan tür: 'note'
  const [tags, setTags] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleFileChange = (e) => {
    const selectedFile = e.target.files[0];
    // Felsefe 4: Yükü Sunucuya Değil, Kullanıcıya Ver. Sadece izin verilen formatları kabul et.
    if (selectedFile && (selectedFile.type === 'application/pdf' || selectedFile.type.startsWith('image/'))) {
      setFile(selectedFile);
      setError('');
    } else {
      setFile(null);
      setError('Lütfen sadece PDF veya resim (JPEG/PNG) dosyası yükleyin.');
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!file || !title || !contentType) {
      setError('Lütfen dosya, başlık ve içerik türü alanlarını doldurun.');
      return;
    }
    if (!isAuthenticated) {
      setError('İçerik yüklemek için giriş yapmalısınız.');
      return;
    }

    setLoading(true);
    setError('');

    // Backend'e göndermek için FormData nesnesi oluşturuyoruz.
    const formData = new FormData();
    formData.append('file', file);

    // Metadata'yı JSON olarak hazırlayıp Blob'a çeviriyoruz.
    const metadata = {
      title,
      description,
      content_type: contentType,
      // Etiketleri virgülle ayırıp bir diziye dönüştürüyoruz.
      tags: tags.split(',').map(tag => tag.trim()).filter(tag => tag),
      // course_id gibi diğer gerekli alanlar buraya eklenebilir. Şimdilik sabit bırakıyoruz.
      course_id: 1, // Bu değer dinamik olarak seçtirilmeli.
    };
    formData.append('metadata', new Blob([JSON.stringify(metadata)], { type: 'application/json' }));

    try {
      const result = await uploadContent(formData);
      // Başarılı yükleme sonrası formu temizle ve üst bileşeni bilgilendir.
      onUploadSuccess(result);
      setFile(null);
      setTitle('');
      setDescription('');
      setContentType('note');
      setTags('');
    } catch (err) {
      setError(err.message || 'Yükleme sırasında bir hata oluştu.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4 p-6 bg-white rounded-lg shadow-md">
      <h2 className="text-xl font-bold">Yeni İçerik Yükle</h2>

      <div>
        <label htmlFor="file-upload" className="block text-sm font-medium text-gray-700">Dosya</label>
        <input id="file-upload" type="file" onChange={handleFileChange} required
               className="mt-1 block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100" />
      </div>

      <Input id="title" label="Başlık" value={title} onChange={(e) => setTitle(e.target.value)} required />

      <div>
        <label htmlFor="description" className="block text-sm font-medium text-gray-700">Açıklama</label>
        <textarea id="description" value={description} onChange={(e) => setDescription(e.target.value)}
                  className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                  rows="3"></textarea>
      </div>

      <div>
        <label htmlFor="content-type" className="block text-sm font-medium text-gray-700">İçerik Türü</label>
        <select id="content-type" value={contentType} onChange={(e) => setContentType(e.target.value)}
                className="mt-1 block w-full px-3 py-2 border border-gray-300 bg-white rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
          <option value="note">Ders Notu</option>
          <option value="exam">Çıkmış Soru</option>
          <option value="slide">Slayt</option>
        </select>
      </div>

      <Input id="tags" label="Etiketler (virgülle ayırın)" value={tags} onChange={(e) => setTags(e.target.value)} placeholder="örn: vize, kalkülüs, 2023" />

      {error && <p className="text-red-600 text-sm">{error}</p>}

      <div className="flex items-center">
        <Button type="submit" variant="primary" disabled={loading}>
          {loading ? 'Yükleniyor...' : 'Yükle'}
        </Button>
        {loading && <Spinner size="sm" className="ml-4" />}
      </div>
    </form>
  );
};

export default UploadForm;
