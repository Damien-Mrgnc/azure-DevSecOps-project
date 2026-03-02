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
RUN npm install --omit=dev
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

# Installer OpenSSL pour Prisma et supprimer NPM (pour nettoyer la vulnérabilité globale minimatch CVE-2026-27903 de Trivy)
RUN apk add --no-cache openssl && rm -rf /usr/local/lib/node_modules/npm /usr/local/bin/npm /usr/local/bin/npx

# Copier les fichiers nécessaires depuis les étapes précédentes avec les bonnes permissions
COPY --chown=appuser:appgroup --from=dependencies /app/node_modules ./node_modules
COPY --chown=appuser:appgroup --from=build /app/node_modules/.prisma ./node_modules/.prisma
COPY --chown=appuser:appgroup --from=build /app/src ./src
COPY --chown=appuser:appgroup --from=build /app/package.json ./package.json
COPY --chown=appuser:appgroup --from=build /app/package-lock.json ./package-lock.json
COPY --chown=appuser:appgroup --from=build /app/prisma ./prisma

# Droits & Port
USER appuser
EXPOSE 8080

# Environment 
ENV NODE_ENV=production
ENV PORT=8080

# Start command
CMD ["/bin/sh", "-c", "./node_modules/.bin/prisma migrate deploy && node src/server.js"]
