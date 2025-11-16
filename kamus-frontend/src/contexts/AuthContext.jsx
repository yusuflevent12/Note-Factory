import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import * as authService from '../api/authService';
import apiClient from '../api/apiClient';

// 1. AuthContext'i oluşturuyoruz. Başlangıç değeri null.
const AuthContext = createContext(null);

// 2. Diğer bileşenlerin bu context'e kolayca erişmesi için bir custom hook yazıyoruz.
export const useAuth = () => {
  return useContext(AuthContext);
};

// 3. AuthProvider bileşenini oluşturuyoruz. Bu bileşen, tüm uygulamayı saracak.
export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true); // Uygulama ilk yüklendiğinde token kontrolü için loading state'i

  // useCallback ile fonksiyonların gereksiz yere yeniden oluşmasını engelliyoruz.
  const initializeAuth = useCallback(async () => {
    const token = localStorage.getItem('authToken');
    if (token) {
      // apiClient'ın varsayılan başlıklarına token'ı ekliyoruz ki getCurrentUser isteği çalışsın.
      apiClient.defaults.headers.common['Authorization'] = `Bearer ${token}`;
      try {
        // Token varsa, backend'den güncel kullanıcı bilgisini alıyoruz.
        const currentUser = await authService.getCurrentUser();
        setUser(currentUser);
      } catch (error) {
        // Token geçersizse (örn: süresi dolmuş), kullanıcıyı sistemden atıyoruz.
        console.error("Token doğrulama hatası:", error);
        authService.logout();
        setUser(null);
      }
    }
    setLoading(false);
  }, []);

  // Bu useEffect, bileşen ilk render edildiğinde sadece bir kez çalışır.
  useEffect(() => {
    initializeAuth();
  }, [initializeAuth]);

  // Login fonksiyonu
  const login = async (credentials) => {
    try {
      const data = await authService.login(credentials);
      // Login başarılı olunca dönen token ile tekrar güncel kullanıcı bilgisini alıyoruz.
      const currentUser = await authService.getCurrentUser();
      setUser(currentUser);
      return data;
    } catch (error) {
      // Hata oluşursa, state'i temizleyip hatayı yukarı iletiyoruz.
      setUser(null);
      throw error;
    }
  };

  // Register fonksiyonu (login'e benzer şekilde çalışabilir veya direkt yönlendirme yapabilir)
  const register = async (userData) => {
    // Genellikle kayıt sonrası otomatik login yaptırılır veya login sayfasına yönlendirilir.
    // Burada şimdilik sadece kayıt işlemini yapıp, sonucu döndürüyoruz.
    return await authService.register(userData);
  };

  // Logout fonksiyonu
  const logout = () => {
    authService.logout();
    setUser(null);
  };

  // Context aracılığıyla paylaşılacak değerler
  const value = {
    user,
    isAuthenticated: !!user, // user nesnesi varsa true, yoksa false döner.
    loading,
    login,
    register,
    logout,
  };

  // Eğer hala token kontrolü yapılıyorsa (loading true ise), bir yükleme ekranı gösterilebilir.
  // Bu, korumalı rotaların kullanıcı bilgisi gelmeden render edilmesini engeller.
  return (
    <AuthContext.Provider value={value}>
      {!loading && children}
    </AuthContext.Provider>
  );
};
