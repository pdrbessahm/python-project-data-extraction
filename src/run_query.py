import argparse
from datetime import date, datetime, timedelta
from src.db import get_engine
from src.extract import run_sql_files

def parse_args():
    p = argparse.ArgumentParser(description="Run saved SQL and export .CSV")
    p.add_argument("--start", help="Start date (YYYY-MM-DD). Default: today-30d")
    p.add_argument("--end", help="End date (YYYY-MM-DD). Default: today")
    p.add_argument("--query", default="last_30d_revenue_by_category.sql", help="SQL file name in sql/queries/")
    p.add_argument("--out", default="last_30d_revenue_by_category.csv", help="Output CSV file name in exports/")
    return p.parse_args()

def to_date(s: str) -> date:
    return datetime.strptime(s, "%Y-%m-%d").date()

if __name__ == "__main__":
    args = parse_args()

    end = to_date(args.end) if args.end else date.today()
    start = to_date(args.start) if args.start else end - timedelta(days=30)

    engine = get_engine()
    out_path = run_sql_files(
        engine, 
        sql_filename=args.query,
        params={"start_date": start, "end_date": end},
        out_csv=args.out
    )
    print(f"✅ Exported → {out_path}")

