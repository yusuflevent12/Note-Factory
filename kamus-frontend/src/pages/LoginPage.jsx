import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import Input from '../components/common/Input';
import Button from '../components/common/Button';
import Spinner from '../components/common/Spinner';

/**
 * Kullanıcı giriş formunu içeren sayfa.
 */
const LoginPage = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const { login } = useAuth();
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    try {
      // API'deki `login` fonksiyonu `username` beklediği için email'i username olarak gönderiyoruz.
      await login({ username: email, password });
      // Başarılı giriş sonrası ana sayfaya yönlendir.
      navigate('/');
    } catch (err) {
      setError(err.detail || 'Giriş yapılamadı. Lütfen bilgilerinizi kontrol edin.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100">
      <div className="w-full max-w-md p-8 space-y-6 bg-white rounded-lg shadow-md">
        <h2 className="text-2xl font-bold text-center">Giriş Yap</h2>
        <form onSubmit={handleSubmit} className="space-y-6">
          <Input
            id="email"
            label="E-posta Adresi"
            type="email"
            name="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="ornek@universite.edu.tr"
            required
          />
          <Input
            id="password"
            label="Şifre"
            type="password"
            name="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
          />
          {error && <p className="text-sm text-red-600">{error}</p>}
          <div>
            <Button type="submit" variant="primary" className="w-full" disabled={loading}>
              {loading ? <Spinner size="sm" /> : 'Giriş Yap'}
            </Button>
          </div>
        </form>
        <p className="text-sm text-center text-gray-600">
          Hesabın yok mu?{' '}
          <Link to="/register" className="font-medium text-blue-600 hover:underline">
            Kayıt Ol
          </Link>
        </p>
      </div>
    </div>
  );
};

export default LoginPage;
