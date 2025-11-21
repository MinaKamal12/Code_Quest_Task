FROM python:3.11

WORKDIR /app

# Install netcat, postgres client, AND redis-cli
RUN apt-get update && apt-get install -y \
    postgresql-client \
    netcat-openbsd \
    redis-tools \
    && rm -rf /var/lib/apt/lists/*

COPY wait-for-health.sh /wait-for-health.sh
RUN chmod +x /wait-for-health.sh

RUN useradd -m -u 1002 appuser

COPY vote/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy all vote files
COPY vote/ .

# Expose the correct port (your app runs on :80)
EXPOSE 80

USER appuser

CMD ["python", "app.py"]
