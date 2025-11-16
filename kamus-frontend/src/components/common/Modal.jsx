import React from 'react';
import ReactDOM from 'react-dom';

/**
 * Ekranın üzerinde bir katman olarak görünen, yeniden kullanılabilir modal (popup) bileşeni.
 * React Portals kullanarak modal'ı DOM'un en üst seviyesine ('modal-root') render eder.
 * @param {object} props - Bileşenin aldığı proplar.
 * @param {boolean} props.isOpen - Modal'ın açık olup olmadığını kontrol eder.
 * @param {function} props.onClose - Modal'ı kapatma fonksiyonu (genellikle arka plana veya kapatma butonuna tıklandığında tetiklenir).
 * @param {React.ReactNode} props.children - Modal'ın içinde gösterilecek içerik.
 * @param {string} [props.title=''] - Modal'ın başlığı.
 */
const Modal = ({ isOpen, onClose, children, title = '' }) => {
  // Eğer modal açık değilse, hiçbir şey render etme (null döndür).
  if (!isOpen) {
    return null;
  }

  // Modal içeriği JSX'i.
  const modalContent = (
    // Arka planı karartan ve tıklanınca modal'ı kapatan overlay div'i.
    <div
      className="fixed inset-0 bg-black bg-opacity-50 z-40 flex items-center justify-center"
      onClick={onClose}
    >
      {/* Asıl modal penceresi. Tıklama olayının overlay'e yayılmasını engelliyoruz (e.stopPropagation). */}
      <div
        className="bg-white rounded-lg shadow-xl p-6 relative z-50 max-w-lg w-full"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Kapatma butonu */}
        <button
          className="absolute top-3 right-3 text-gray-500 hover:text-gray-800"
          onClick={onClose}
          aria-label="Kapat"
        >
          &times; {/* Çarpı işareti */}
        </button>

        {/* Modal başlığı */}
        {title && (
          <h2 className="text-xl font-semibold mb-4">{title}</h2>
        )}

        {/* Modal içeriği */}
        <div>{children}</div>
      </div>
    </div>
  );

  // ReactDOM.createPortal kullanarak modal içeriğini 'modal-root' id'li DOM elemanına render ediyoruz.
  // Bu, modal'ın CSS ve z-index sorunlarından etkilenmemesini sağlar.
  // public/index.html dosyasında <div id="modal-root"></div> bulunmalıdır.
  return ReactDOM.createPortal(
    modalContent,
    document.getElementById('modal-root')
  );
};

export default Modal;
