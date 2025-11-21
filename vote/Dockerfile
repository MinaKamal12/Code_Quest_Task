FROM python:3.11

WORKDIR /app

# Install needed tools
RUN apt-get update && apt-get install -y \
    postgresql-client \
    netcat-openbsd \
    redis-tools && \
    rm -rf /var/lib/apt/lists/*

COPY wait-for-health.sh /wait-for-health.sh
RUN chmod +x /wait-for-health.sh

RUN useradd -m -u 1002 appuser

COPY vote/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY vote/ .

ENV PATH="/usr/bin:${PATH}"

USER appuser

EXPOSE 80
CMD ["python", "app.py"]
