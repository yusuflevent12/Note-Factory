import axios from 'axios';

// .env dosyasından backend'in temel URL'sini alıyoruz.
// Vite, `VITE_` önekiyle başlayan ortam değişkenlerini otomatik olarak işler.
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000/api/v1';

const apiClient = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// API istemcisine bir "interceptor" (araya girici) ekliyoruz.
// Bu, her istek gönderilmeden hemen önce çalışacak bir fonksiyondur.
apiClient.interceptors.request.use(
  (config) => {
    // Tarayıcının yerel depolamasından (localStorage) token'ı alıyoruz.
    const token = localStorage.getItem('authToken');

    // Eğer token varsa, isteğin 'Authorization' başlığına ekliyoruz.
    // Backend bu başlığı okuyarak kullanıcının kimliğini doğrulayacak.
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`;
    }

    return config; // Değiştirilmiş config'i isteğe devam etmesi için geri döndürüyoruz.
  },
  (error) => {
    // İstek yapılandırmasında bir hata olursa, bu hatayı Promise.reject ile reddediyoruz.
    return Promise.reject(error);
  }
);

export default apiClient;
