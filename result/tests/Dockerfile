FROM node:18-slim

# Create app directory
WORKDIR /usr/src/app

# Copy package files first
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy rest of app code
COPY . .

# Expose port
EXPOSE 4000

# Start the result server
CMD ["node", "server.js"]
