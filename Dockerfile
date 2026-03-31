FROM node:20-alpine
WORKDIR /app

COPY src/package*.json ./

RUN npm install --omit=dev

COPY src/ .

ENV PORT=80
EXPOSE 80

USER node
CMD ["node", "index.js"]