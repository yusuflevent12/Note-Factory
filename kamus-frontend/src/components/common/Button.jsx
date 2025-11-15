import React from 'react';

const Button = ({ children, onClick, type = 'button' }) => {
  return (
    <button
      type={type}
      onClick={onClick}
      style={{ padding: '10px 15px', border: 'none', background: '#007bff', color: 'white', cursor: 'pointer' }}
    >
      {children}
    </button>
  );
};

export default Button;
