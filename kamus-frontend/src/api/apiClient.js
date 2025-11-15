import axios from 'axios';

// 1. .env dosyasından API adresini oku
const VITE_API_BASE_URL = import.meta.env.VITE_API_BASE_URL || "http://127.0.0.1:8000";

// 2. Ana Axios "istemcisini" (client) oluştur
const apiClient = axios.create({
  baseURL: VITE_API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// 3. (Gelecekte Login olunca) Token'ı otomatik ekleme
// apiClient.interceptors.request.use( (config) => { ... } );

export default apiClient;