import React from 'react';

/**
 * Proje genelinde kullanılacak standart bir buton bileşeni.
 * @param {object} props - Bileşenin aldığı proplar.
 * @param {React.ReactNode} props.children - Butonun içinde görünecek içerik (metin, ikon vb.).
 * @param {function} props.onClick - Butona tıklandığında çalışacak fonksiyon.
 * @param {string} [props.type='button'] - Butonun tipi ('button', 'submit', 'reset').
 * @param {string} [props.variant='primary'] - Butonun stil varyantı ('primary', 'secondary', 'danger').
 * @param {boolean} [props.disabled=false] - Butonun pasif olup olmadığını belirtir.
 * @param {string} [props.className=''] - Butona eklenecek ek CSS sınıfları.
 */
const Button = ({ children, onClick, type = 'button', variant = 'primary', disabled = false, className = '' }) => {
  // Stil varyantlarına göre CSS sınıflarını belirleyen bir mantık.
  // Gerçek projede bu sınıflar bir CSS/SCSS dosyasından veya Tailwind gibi bir framework'ten gelir.
  const baseStyle = 'px-4 py-2 font-semibold rounded-md focus:outline-none focus:ring-2 focus:ring-opacity-75 transition-colors duration-200';
  const variantStyles = {
    primary: 'bg-blue-600 text-white hover:bg-blue-700 focus:ring-blue-500',
    secondary: 'bg-gray-200 text-gray-800 hover:bg-gray-300 focus:ring-gray-400',
    danger: 'bg-red-600 text-white hover:bg-red-700 focus:ring-red-500',
  };
  const disabledStyle = 'opacity-50 cursor-not-allowed';

  const combinedClassName = `
    ${baseStyle}
    ${variantStyles[variant]}
    ${disabled ? disabledStyle : ''}
    ${className}
  `.trim();

  return (
    <button
      type={type}
      onClick={onClick}
      disabled={disabled}
      className={combinedClassName}
    >
      {children}
    </button>
  );
};

export default Button;
