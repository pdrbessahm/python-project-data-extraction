from sqlalchemy import create_engine
from sqlalchemy.engine import Engine
from dotenv import load_dotenv
import os

load_dotenv() 
# loads variables from .env

def get_engine() -> Engine:
    host = os.getenv("DB_HOST", "localhost")
    port = os.getenv("DB_PORT", "3306")
    user = os.getenv("DB_USER", "root")
    pwd  = os.getenv("DB_PASS", "")
    name = os.getenv("DB_NAME", "data_extraction")

    url = f"mysql+pymysql://{user}:{pwd}@{host}:{port}/{name}"
    # echo=False to keep logs quiet; set True if you want SQL printed

    return create_engine(url, future=True, pool_pre_ping=True)