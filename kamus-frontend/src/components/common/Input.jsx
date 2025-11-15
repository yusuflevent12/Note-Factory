import React from 'react';

const Input = ({ type, placeholder, value, onChange }) => {
  return (
    <input
      type={type}
      placeholder={placeholder}
      value={value}
      onChange={onChange}
      style={{ padding: '10px', marginBottom: '10px', width: '100%', boxSizing: 'border-box' }}
    />
  );
};

export default Input;
