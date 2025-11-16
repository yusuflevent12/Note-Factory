import React from 'react';

/**
 * Her sayfanın en altında görünecek olan alt bilgi (footer) bileşeni.
 */
const Footer = () => {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="bg-white border-t border-gray-200 mt-auto">
      <div className="max-w-7xl mx-auto py-4 px-4 sm:px-6 lg:px-8">
        <div className="text-center text-sm text-gray-500">
          <p>&copy; {currentYear} Kampüs Çekirdeği. Tüm hakları saklıdır.</p>
          <p className="mt-1">
            <a href="/about" className="hover:underline">Hakkımızda</a> |
            <a href="/contact" className="hover:underline ml-2">İletişim</a> |
            <a href="/privacy" className="hover:underline ml-2">Gizlilik Politikası</a>
          </p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
