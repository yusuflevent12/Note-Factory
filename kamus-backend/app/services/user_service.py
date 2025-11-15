from sqlalchemy.orm import Session
from app.models import user
from app.core.security import get_password_hash
from app.schemas import user

def get_user_by_email(db: Session, email: str):
    return db.query(user.User).filter(user.User.email == email).first()

def create_user(db: Session, user: user.UserCreate):
    hashed_password = get_password_hash(user.password)
    db_user = user.User(email=user.email, hashed_password=hashed_password)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user
