from pathlib import Path
from sqlalchemy import text
from sqlalchemy.engine import Engine
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
QUERIES_DIR = ROOT / "sql" / "queries" 
EXPORTS_DIR = ROOT / "exports"

def run_sql_files(engine: Engine, sql_filename: str, params: dict, out_csv: str) -> Path:
    """
    Load a .sql file (with :param placeholders), execute it, and export the result to CSV
    """

    EXPORTS_DIR.mkdir(parents=True, exist_ok=True)
    sql_text = (QUERIES_DIR / sql_filename).read_text(encoding="utf-8")

    # Read into a DataFrame
    df = pd.read_sql(text(sql_text), con=engine, params=params)

    out_path = EXPORTS_DIR / out_csv
    df.to_csv(out_path, index=False)
    return out_path