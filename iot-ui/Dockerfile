# Stage 1: Build the React app
FROM node:18-alpine AS builder

WORKDIR /app

# Copy app source code
COPY iot-ui/package*.json ./
RUN npm install

COPY iot-ui/. .
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]