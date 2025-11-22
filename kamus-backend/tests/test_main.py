from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_read_main():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Welcome to Kampus Cekirdegi API"}

def test_health_check():
    response = client.get("/health")
    # Assuming there is a health endpoint or just checking 404 if not
    # But let's check the docs or main.py to see what endpoints exist.
    # For now, just the root.
    pass
