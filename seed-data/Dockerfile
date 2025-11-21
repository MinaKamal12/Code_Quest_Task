FROM python:3.11

WORKDIR /app

# Install netcat for health checks
RUN apt-get update && apt-get install -y postgresql-client netcat-openbsd && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir psycopg2-binary

# Copy all seed-data files
COPY seed-data/ .

COPY wait-for-health.sh /wait-for-health.sh
RUN chmod +x /wait-for-health.sh

CMD ["python", "seed_data.py"]
