FROM node:20-alpine
WORKDIR /app
COPY src/package*.json ./
RUN npm install --omit=dev
COPY src/ .

# Cambiamos esto a 3000 para que coincida con TODO
ENV PORT=3000
EXPOSE 3000

USER node
CMD ["node", "index.js"]