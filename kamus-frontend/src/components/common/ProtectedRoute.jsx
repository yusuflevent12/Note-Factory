import React from 'react';
import { Navigate, Outlet } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';

/**
 * Bir rotayı sadece giriş yapmış kullanıcıların erişimine açan sarmalayıcı bileşen.
 * Kullanıcı giriş yapmamışsa, onu login sayfasına yönlendirir.
 * @param {object} props - Bileşenin aldığı proplar.
 * @param {string} [props.redirectTo='/login'] - Yönlendirilecek sayfanın yolu.
 */
const ProtectedRoute = ({ redirectTo = '/login' }) => {
  const { isAuthenticated, loading } = useAuth();

  // AuthContext hala token'ı doğruluyorsa (ilk yükleme anı),
  // henüz bir şey render etme. Bu, istenmeyen yönlendirmeleri önler.
  if (loading) {
    return null; // Veya bir yükleme spinner'ı gösterilebilir.
  }

  // Kullanıcı giriş yapmışsa, alt rotaları (children) render et.
  // <Outlet /> react-router-dom'dan gelir ve iç içe geçmiş rotaların render edileceği yeri belirtir.
  return isAuthenticated ? <Outlet /> : <Navigate to={redirectTo} />;
};

export default ProtectedRoute;
