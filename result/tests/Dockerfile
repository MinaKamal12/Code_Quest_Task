FROM node:20

WORKDIR /usr/src/app

# Install health check tools
RUN apt-get update && apt-get install -y postgresql-client redis-tools netcat-openbsd && rm -rf /var/lib/apt/lists/*

COPY ../wait-for-health.sh /wait-for-health.sh
RUN chmod +x /wait-for-health.sh

COPY package*.json ./
RUN npm install --production

COPY . .

EXPOSE 4000

CMD ["node", "server.js"]
