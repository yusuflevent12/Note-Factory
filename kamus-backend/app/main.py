from fastapi import FastAPI
from .db.base import Base
from .db.session import engine
from .api.v1.api_router import api_router

Base.metadata.create_all(bind=engine)

app = FastAPI()

app.include_router(api_router, prefix="/api/v1")

@app.get("/")
def read_root():
    return {"message": "Welcome to Kampus Cekirdegi API"}
