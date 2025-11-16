import React from 'react';
import Navbar from '../components/layout/Navbar';
import Sidebar from '../components/layout/Sidebar';
import Footer from '../components/layout/Footer';

/**
 * Uygulamanın ana sayfası (giriş sayfası).
 * Genel sayfa düzenini (Navbar, Sidebar, Footer) sergiler.
 */
const HomePage = () => {
  return (
    <div className="flex flex-col min-h-screen bg-gray-50">
      <Navbar />
      <div className="flex flex-1">
        <Sidebar />
        <main className="flex-1 p-8">
          <div className="bg-white p-6 rounded-lg shadow-md">
            <h1 className="text-3xl font-bold text-gray-800">Kampüs Çekirdeği'ne Hoş Geldiniz!</h1>
            <p className="mt-4 text-gray-600">
              Ders materyallerinize (notlar, çıkmış sorular, slaytlar) kolayca erişin,
              kendi notlarınızı paylaşın ve topluluğun en iyi içeriklerini oylayarak öne çıkarın.
            </p>
            <p className="mt-2 text-gray-600">
              Başlamak için sol taraftaki menüden bir bölüm seçin.
            </p>
          </div>
        </main>
      </div>
      <Footer />
    </div>
  );
};

export default HomePage;
