import React from 'react';

/**
 * Bir işlemin yüklenmekte olduğunu göstermek için kullanılan, dönen bir çember (spinner) bileşeni.
 * @param {object} props - Bileşenin aldığı proplar.
 * @param {string} [props.size='md'] - Spinner'ın boyutu ('sm', 'md', 'lg').
 * @param {string} [props.className=''] - Spinner'a eklenecek ek CSS sınıfları.
 * @param {string} [props.text=''] - Spinner'ın yanında görünecek isteğe bağlı metin.
 */
const Spinner = ({ size = 'md', className = '', text = '' }) => {
  const sizeClasses = {
    sm: 'w-6 h-6 border-2',
    md: 'w-10 h-10 border-4',
    lg: 'w-16 h-16 border-4',
  };

  const spinnerClassName = `
    animate-spin rounded-full border-blue-500 border-t-transparent
    ${sizeClasses[size]}
    ${className}
  `.trim();

  return (
    <div className="flex flex-col items-center justify-center" role="status" aria-label="Yükleniyor...">
      <div className={spinnerClassName}></div>
      {text && <span className="mt-2 text-gray-600">{text}</span>}
    </div>
  );
};

export default Spinner;
