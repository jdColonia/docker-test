# ETAPA 1
# Construcción de la aplicación
FROM node:18 AS build

WORKDIR /app

# Copiar y descargar dependencias
COPY package.json package-lock.json ./
RUN npm install --frozen-lockfile

# Copiar el resto del código
COPY . .

# Construir la aplicación
RUN npm run build

# ETAPA 2
# Servir la aplicación con Nginx
FROM nginx:stable-alpine AS production

# Copiar los archivos generados en la etapa de construcción
COPY --from=build /app/build /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80

# Iniciar nginx
CMD ["nginx", "-g", "daemon off;"]
