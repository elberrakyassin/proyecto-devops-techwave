# Usamos una imagen ligera de Node.js basada en Alpine Linux
FROM node:20-alpine

# Creamos el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos solo los archivos de dependencias primero (optimización de capas)
COPY src/package*.json ./

# Instalamos solo las dependencias de producción
RUN npm install --only=production

# Copiamos el resto del código de la aplicación
COPY src/ .

# Por seguridad, no ejecutamos como root
USER node

# Exponemos el puerto que definimos en la app
EXPOSE 3000

# Comando para arrancar la aplicación
CMD ["node", "index.js"]