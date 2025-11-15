import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import Input from '../../components/common/Input';
import Button from '../../components/common/Button';

const LoginPage = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const navigate = useNavigate();

  const handleLogin = (e) => {
    e.preventDefault();
    // Sahte giriş işlemi
    console.log('Giriş yapılıyor:', { email, password });
    navigate('/');
  };

  return (
    <div style={{ maxWidth: '400px', margin: 'auto' }}>
      <h2>Giriş Yap</h2>
      <form onSubmit={handleLogin}>
        <Input
          type="email"
          placeholder="E-posta"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
        <Input
          type="password"
          placeholder="Şifre"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
        <Button type="submit">Giriş Yap</Button>
      </form>
    </div>
  );
};

export default LoginPage;
