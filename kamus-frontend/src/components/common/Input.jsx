import React from 'react';

/**
 * Proje genelinde kullanılacak standart bir form giriş (input) bileşeni.
 * @param {object} props - Bileşenin aldığı proplar.
 * @param {string} props.id - Input ve label'ı birbirine bağlamak için benzersiz ID.
 * @param {string} props.label - Input'un üstünde görünecek etiket metni.
 * @param {string} props.type - Input'un tipi ('text', 'email', 'password', 'number' vb.).
 * @param {string} props.name - Form verisinde input'u temsil edecek isim.
 * @param {string|number} props.value - Input'un mevcut değeri.
 * @param {function} props.onChange - Input'un değeri değiştiğinde çalışacak fonksiyon.
 * @param {string} [props.placeholder=''] - Input boşken görünecek ipucu metni.
 * @param {string} [props.error=null] - Eğer varsa, input'un altında gösterilecek hata mesajı.
 * @param {boolean} [props.disabled=false] - Input'un pasif olup olmadığını belirtir.
 * @param {string} [props.className=''] - Input'a eklenecek ek CSS sınıfları.
 */
const Input = ({ id, label, type = 'text', name, value, onChange, placeholder = '', error = null, disabled = false, className = '' }) => {
  const baseStyle = 'w-full px-3 py-2 border rounded-md focus:outline-none transition-colors duration-200';
  const normalStyle = 'border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500';
  const errorStyle = 'border-red-500 focus:ring-2 focus:ring-red-500';
  const disabledStyle = 'bg-gray-100 cursor-not-allowed';

  const combinedClassName = `
    ${baseStyle}
    ${error ? errorStyle : normalStyle}
    ${disabled ? disabledStyle : ''}
    ${className}
  `.trim();

  return (
    <div className="w-full">
      <label htmlFor={id} className="block text-sm font-medium text-gray-700 mb-1">
        {label}
      </label>
      <input
        id={id}
        type={type}
        name={name}
        value={value}
        onChange={onChange}
        placeholder={placeholder}
        disabled={disabled}
        className={combinedClassName}
        aria-invalid={!!error}
        aria-describedby={error ? `${id}-error` : undefined}
      />
      {error && (
        <p id={`${id}-error`} className="mt-1 text-sm text-red-600">
          {error}
        </p>
      )}
    </div>
  );
};

export default Input;
