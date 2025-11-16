import apiClient from './apiClient';

/**
 * Belirli bir derse ait tüm içerikleri getirmek için backend'e istek gönderir.
 * @param {number} courseId - İçeriklerin getirileceği dersin ID'si.
 * @returns {Promise<Array>} Derse ait içeriklerin bir dizisi.
 */
export const getContentByCourse = async (courseId) => {
  try {
    const response = await apiClient.get(`/content/course/${courseId}`);
    return response.data;
  } catch (error) {
    console.error(`Failed to fetch content for course ${courseId}:`, error.response?.data || error.message);
    throw error.response?.data || error;
  }
};

/**
 * Belirli bir içeriğin detaylarını getirmek için backend'e istek gönderir.
 * @param {number} contentId - Detayları getirilecek içeriğin ID'si.
 * @returns {Promise<object>} İçeriğin detay verileri.
 */
export const getContentDetails = async (contentId) => {
  try {
    const response = await apiClient.get(`/content/${contentId}`);
    return response.data;
  } catch (error) {
    console.error(`Failed to fetch content details for ${contentId}:`, error.response?.data || error.message);
    throw error.response?.data || error;
  }
};

/**
 * Yeni bir içerik (dosya ve meta verileri) yüklemek için backend'e istek gönderir.
 * Bu fonksiyon 'multipart/form-data' kullanarak hem dosyayı hem de JSON verisini gönderir.
 * @param {FormData} formData - Dosya ve içerik meta verilerini ('tags', 'description' vb.) içeren FormData nesnesi.
 *   Örnek FormData yapısı:
 *   formData.append('file', file); // Yüklenecek dosya
 *   formData.append('metadata', new Blob([JSON.stringify({
 *     title: 'Final Sınavı Soruları',
 *     description: 'Geçen yılın final soruları.',
 *     course_id: 1,
 *     content_type: 'exam',
 *     tags: ['final', 'calculus']
 *   })], { type: 'application/json' }));
 * @returns {Promise<object>} Başarılı yükleme sonrası oluşturulan içerik verisi.
 */
export const uploadContent = async (formData) => {
  try {
    const response = await apiClient.post('/content/upload', formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    return response.data;
  } catch (error) {
    console.error('Content upload failed:', error.response?.data || error.message);
    throw error.response?.data || error;
  }
};

/**
 * Bir içeriğe oy vermek (upvote/downvote) için backend'e istek gönderir.
 * @param {number} contentId - Oylanacak içeriğin ID'si.
 * @param {string} voteType - Oy türü, 'upvote' veya 'downvote'.
 * @returns {Promise<object>} Oylama sonrası güncellenmiş içerik verisi.
 */
export const voteOnContent = async (contentId, voteType) => {
  try {
    const response = await apiClient.post(`/content/${contentId}/vote`, { vote_type: voteType });
    return response.data;
  } catch (error) {
    console.error(`Failed to vote on content ${contentId}:`, error.response?.data || error.message);
    throw error.response?.data || error;
  }
};
