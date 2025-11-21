FROM python:3.11

WORKDIR /app

# Install netcat and postgresql client for health checks
RUN apt-get update && apt-get install -y postgresql-client netcat-openbsd && rm -rf /var/lib/apt/lists/*

COPY wait-for-health.sh /wait-for-health.sh
RUN chmod +x /wait-for-health.sh

RUN useradd -m -u 1002 appuser

COPY vote/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN apt-get update && apt-get install -y redis-tools


# Copy all vote files (this includes app.py)
COPY vote/ .

USER appuser

EXPOSE 8000

CMD ["python", "app.py"]