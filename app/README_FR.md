# Application de Gouvernance Dynamique (Runtime Governance App)

## Description
Il s'agit d'une application de gouvernance dynamique construite avec Node.js 20, Express, Prisma et Azure SQL. Elle permet de modifier le comportement du site via une interface d'administration sans redéploiement complet, tout en conservant une piste d'audit (Audit Trail).

## Fonctionnalités Principales
*   **Affichage Dynamique** : Titre, description, thème et mode maintenance configurables en temps réel.
*   **API Administrateur** : Point de terminaison protégé pour la mise à jour de la configuration.
*   **Sécurité** : Utilisation de Managed Identity pour la connexion à la base de données SQL et l'accès aux secrets Key Vault.
*   **Observabilité** : Logs structurés au format JSON pour l'ingestion par Azure Monitor.

## Architecture Technique
*   `src/api` : Définition des routes REST.
*   `src/services` : Logique métier (Configuration, Key Vault).
*   `src/middleware` : Authentification et Logging.
*   `src/views` : Interface utilisateur (Server-Side Rendering avec EJS).
*   `prisma` : Schéma de base de données SQL Server et migrations.

## Prérequis Azure
L'application nécessite les ressources Azure suivantes :
*   Azure App Service (Conteneur Linux).
*   Azure SQL Database.
*   Azure Key Vault.
*   Managed Identity activée sur l'App Service avec les rôles appropriés (`Key Vault Secrets User`).

## Développement Local
Pour exécuter l'application localement via Docker :
1.  Copier le fichier `.env.example` vers `.env`.
2.  Démarrer la base de données locale : `docker-compose up -d db`.
3.  Installer les dépendances : `npm install`.
4.  Appliquer les migrations : `npx prisma migrate dev`.
5.  Démarrer le serveur de développement : `npm run dev`.

## Déploiement Azure
Le déploiement est automatisé via GitHub Actions :
1.  Construction de l'image Docker et envoi vers Azure Container Registry (ACR).
2.  Déploiement de l'image sur l'App Service.

### Variables d'Environnement
*   `DATABASE_URL` : Chaîne de connexion à la base de données (authentification MSI).
*   `KEY_VAULT_URL` : URL de l'instance Azure Key Vault.
*   `NODE_ENV` : `production`.
*   `PORT` : `8080`.
