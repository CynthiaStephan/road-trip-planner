FROM node:24

WORKDIR /app

# Copier package.json + package-lock
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le code source
COPY . .

# Exposer le port de Vite
EXPOSE 5173

# Lancer Vite en mode dev (host obligatoire pour Docker)
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]