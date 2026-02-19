# ---- Base Node ----
FROM node:20-alpine AS base
WORKDIR /app

# Upgrade OS packages to fix vulnerabilities
RUN apk update && apk upgrade --no-cache && apk add --no-cache openssl
COPY package*.json ./

# ---- Dependencies ----
FROM base AS dependencies
# Installer dépendances production UNIQUEMENT
# Force l'utilisation du package-lock.json à jour qui contient les correctifs
RUN npm ci --only=production
COPY prisma ./prisma/

# ---- Build ----
FROM base AS build
# Installer TOUT (y compris devDependencies pour le build Prisma si besoin)
RUN npm install
COPY . .
RUN npx prisma generate

# ---- Release ----
FROM node:20-alpine AS release
WORKDIR /app

# Sécurité : créer utilisateur non-root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Installer OpenSSL pour Prisma et mettre à jour NPM pour corriger les vulnérabilités
RUN apk add --no-cache openssl && npm install -g npm@latest

# Copier les fichiers nécessaires depuis les étapes précédentes avec les bonnes permissions
COPY --chown=appuser:appgroup --from=dependencies /app/node_modules ./node_modules
COPY --chown=appuser:appgroup --from=build /app/node_modules/.prisma ./node_modules/.prisma
COPY --chown=appuser:appgroup --from=build /app/src ./src
COPY --chown=appuser:appgroup --from=build /app/package.json ./package.json
COPY --chown=appuser:appgroup --from=build /app/prisma ./prisma

# Droits & Port
USER appuser
EXPOSE 8080

# Environment (Peut être surchargé par Azure App Service)
ENV NODE_ENV=production
ENV PORT=8080

# Start command
# Using node direct execution instead of npm start to avoid npm vulnerabilities
CMD ["/bin/sh", "-c", "npx prisma migrate deploy && node src/server.js"]
