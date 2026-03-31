FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production
COPY src/ .

# Forzamos a la aplicación a usar el puerto 80
ENV PORT=80
EXPOSE 80

# Usamos el usuario no-privilegiado por seguridad (como hicimos en la Fase 1)
USER node
CMD ["node", "index.js"]