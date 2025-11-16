import React from 'react';
import { Link, NavLink } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import Button from '../common/Button';

const Navbar = () => {
  const { isAuthenticated, user, logout } = useAuth();

  return (
    <nav className="bg-white shadow-md">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          {/* Logo ve Ana Sayfa Linki */}
          <div className="flex-shrink-0">
            <Link to="/" className="text-2xl font-bold text-blue-600">
              Kampüs Çekirdeği
            </Link>
          </div>

          {/* Navigasyon Linkleri (Orta) */}
          <div className="hidden md:block">
            <div className="ml-10 flex items-baseline space-x-4">
              <NavLink
                to="/"
                className={({ isActive }) =>
                  `px-3 py-2 rounded-md text-sm font-medium ${
                    isActive ? 'bg-blue-600 text-white' : 'text-gray-700 hover:bg-gray-200'
                  }`
                }
              >
                Ana Sayfa
              </NavLink>
              <NavLink
                to="/upload"
                className={({ isActive }) =>
                  `px-3 py-2 rounded-md text-sm font-medium ${
                    isActive ? 'bg-blue-600 text-white' : 'text-gray-700 hover:bg-gray-200'
                  }`
                }
              >
                Not Yükle
              </NavLink>
              {/* Diğer linkler buraya eklenebilir */}
            </div>
          </div>

          {/* Sağ Taraftaki Kullanıcı Alanı */}
          <div className="flex items-center">
            {isAuthenticated ? (
              <div className="flex items-center space-x-4">
                <span className="text-gray-800">Merhaba, {user?.full_name || user?.email}</span>
                <Button onClick={logout} variant="secondary" className="text-sm">
                  Çıkış Yap
                </Button>
              </div>
            ) : (
              <div className="space-x-2">
                <Link to="/login">
                  <Button variant="primary">Giriş Yap</Button>
                </Link>
                {/* İsteğe bağlı olarak kayıt butonu da eklenebilir */}
              </div>
            )}
          </div>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;
