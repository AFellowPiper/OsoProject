# Dockerfile - zoptymalizowana wersja
FROM node:18-alpine

WORKDIR /juice-shop

# Kopiuj pliki package.json
COPY package*.json ./

# Instaluj zależności
RUN npm ci --only=production && npm cache clean --force

# Kopiuj resztę aplikacji
COPY . .

# Utwórz użytkownika bez uprawnień root
RUN addgroup -g 1001 -S juice && \
    adduser -S juice -u 1001

# Zmień właściciela plików
RUN chown -R juice:juice /juice-shop
USER juice

EXPOSE 3000

CMD ["npm", "start"]
