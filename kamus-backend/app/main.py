from fastapi import FastAPI
import logging

from .db.base import Base
from .db.session import engine
from .api.v1.api_router import api_router

# Import all models to ensure SQLAlchemy relationships are resolved
from . import models  # noqa: F401
from .models import user, content, hierarchy  # noqa: F401

# Configure logging to show errors in terminal
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

Base.metadata.create_all(bind=engine)

app = FastAPI()

app.include_router(api_router, prefix="/api/v1")

@app.get("/")
def read_root():
    return {"message": "Welcome to Kampus Cekirdegi API"}
