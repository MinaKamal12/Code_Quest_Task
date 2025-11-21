FROM node:20

WORKDIR /app

# Install netcat and postgresql client for health checks
RUN apt-get update && apt-get install -y postgresql-client redis-tools netcat-openbsd && rm -rf /var/lib/apt/lists/*

COPY wait-for-health.sh /wait-for-health.sh
RUN chmod +x /wait-for-health.sh

RUN useradd -m -u 1002 appuser

COPY result/package*.json ./

RUN chown -R appuser:appuser /app

RUN npm install --no-cache

# Copy all result files (this includes service.js)
COPY result/ .

USER appuser

EXPOSE 4000

CMD ["node", "server.js"]