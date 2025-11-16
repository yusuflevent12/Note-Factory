import apiClient from './apiClient';

/**
 * Kullanıcı girişi için backend'e istek gönderir.
 * @param {object} credentials - Kullanıcının giriş bilgileri (örn: { username, password }).
 * @returns {Promise<object>} Giriş başarılı olursa sunucudan dönen veri (örn: { access_token, user }).
 */
export const login = async (credentials) => {
  try {
    // FastAPI'nin OAuth2PasswordRequestForm'u 'application/x-www-form-urlencoded' formatında veri bekler.
    // Bu yüzden isteği bu formata uygun hazırlıyoruz.
    const formData = new URLSearchParams();
    formData.append('username', credentials.username);
    formData.append('password', credentials.password);

    const response = await apiClient.post('/auth/login', formData, {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    });

    // Eğer sunucudan bir token geldiyse, bunu yerel depolamaya kaydediyoruz.
    if (response.data.access_token) {
      localStorage.setItem('authToken', response.data.access_token);
      // Başarılı giriş sonrası, interceptor'ın bir sonraki istekte token'ı kullanabilmesi için
      // apiClient'ın varsayılan başlıklarını güncelleyebiliriz (opsiyonel ama iyi bir pratik).
      apiClient.defaults.headers.common['Authorization'] = `Bearer ${response.data.access_token}`;
    }
    return response.data;
  } catch (error) {
    // Hata durumunda, hatayı yakalayıp daha iyi bir hata mesajı için işleyebiliriz.
    console.error('Login failed:', error.response?.data || error.message);
    throw error.response?.data || error;
  }
};

/**
 * Yeni bir kullanıcı kaydı oluşturmak için backend'e istek gönderir.
 * @param {object} userData - Yeni kullanıcının bilgileri (örn: { email, password, full_name }).
 * @returns {Promise<object>} Başarılı kayıt sonrası oluşturulan kullanıcı verisi.
 */
export const register = async (userData) => {
  try {
    const response = await apiClient.post('/auth/register', userData);
    return response.data;
  } catch (error) {
    console.error('Registration failed:', error.response?.data || error.message);
    throw error.response?.data || error;
  }
};

/**
 * Kullanıcının oturumunu sonlandırır.
 */
export const logout = () => {
  // Yerel depolamadan token'ı kaldırıyoruz.
  localStorage.removeItem('authToken');
  // apiClient'ın varsayılan başlıklarından token'ı temizliyoruz.
  delete apiClient.defaults.headers.common['Authorization'];
};

/**
 * Mevcut (giriş yapmış) kullanıcının bilgilerini getirmek için backend'e istek gönderir.
 * @returns {Promise<object>} Giriş yapmış kullanıcının verisi.
 */
export const getCurrentUser = async () => {
  try {
    const response = await apiClient.get('/users/me');
    return response.data;
  } catch (error) {
    console.error('Failed to fetch current user:', error.response?.data || error.message);
    throw error.response?.data || error;
  }
};
