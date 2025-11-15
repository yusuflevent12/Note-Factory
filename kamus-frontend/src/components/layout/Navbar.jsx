import React from 'react';
import { Link } from 'react-router-dom';

const Navbar = () => {
  return (
    <nav style={{ padding: '10px', background: '#f0f0f0', borderBottom: '1px solid #ccc' }}>
      <Link to="/" style={{ marginRight: '15px' }}>Ana Sayfa</Link>
      <Link to="/login" style={{ marginRight: '15px' }}>Giriş Yap</Link>
      <Link to="/upload">Not Yükle</Link>
    </nav>
  );
};

export default Navbar;
