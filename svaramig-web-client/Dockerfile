# Stage 1: Build the React app
FROM node:18-alpine AS builder

WORKDIR /app

# Copy app source code
COPY svaramig/package*.json ./
RUN npm install

COPY svaramig/. .
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]