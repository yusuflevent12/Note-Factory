from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
import logging

from .db.base import Base
from .db.session import engine
from .api.v1.api_router import api_router

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(title="Kampus Cekirdegi API")

# Basit CORS; production'da allow_origins'i daraltın
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.on_event("startup")
async def startup_event():
    try:
        # DB tablolarını startup'ta oluştur — import sırasında değil
        Base.metadata.create_all(bind=engine)
        logger.info("Database tables ensured/created successfully.")
    except Exception as e:
        # DB başlatma hatalarını yutma ama logla. (Opsiyonel: burada bir 'ready' flag'i false yap)
        logger.exception("Database initialization failed: %s", e)

# Global hata yakalayıcı: uncaught exception'larda JSON 500 dön
@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    logger.exception("Unhandled exception for request %s: %s", request.url, exc)
    return JSONResponse(status_code=500, content={"detail": "Internal Server Error"})

app.include_router(api_router, prefix="/api/v1")

@app.get("/")
def read_root():
    return {"message": "Welcome to Kampus Cekirdegi API"}