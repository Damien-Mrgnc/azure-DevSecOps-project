# Plan d'Action - Projet 2 DevSecOps

Ce document sert de base pour l'industrialisation du Projet 1 via une approche DevSecOps.

## 🎯 Objectif Principal
Mettre en place une chaîne CI/CD complète, sécurisée et automatisée pour déployer l'infrastructure et l'application du Projet 1.

## 📋 État des lieux (Projet 1)
- Architecture Cloud Azure existante (App Service, SQL, Key Vault, etc.).
- Code Terraform fonctionnel.
- Application Node.js (Runtime Governance App).
- Dépôt Git initialisé (à migrer vers Projet 2).

## 🚀 Phases de Réalisation

### Phase 0 : Initialisation et Nettoyage
1.  **Récupération du Code** : [x] Copie des sources du Projet 1 (`app`, `terraform`).
2.  **Nettoyage** : [x] Suppression des fichiers inutiles (`.git`, `node_modules`, `terraform.tfstate`) ou exclusion via `.gitignore`.
3.  **Initialisation Git** : [x] Création d'un nouveau dépôt propre pour le Projet 2 et push initial.
4.  **Configuration Environnement** : [ ] Vérification des accès Azure et prérequis CI/CD (Service Principal, OIDC).

### Phase 1 : Pipeline d'Intégration Continue (CI) - Application
*Objectif : Mettre en place la construction et la validation du code applicatif.*
1.  **Workflow GitHub Actions** (`.github/workflows/app-ci.yml`) :
    -   Déclenchement sur Pull Request et Push (main).
    -   **Checkout** du code.
    -   **Setup Node.js**.
    -   **Install Dependencies** (npm ci).
    -   **Linting & Tests Unitaires**.
    -   **Security Scan (SAST)** : Integration de CodeQL ou SonarCloud.
    -   **Container Build** : Construction de l'image Docker.
    -   **Container Scan** : Analyse des vulnérabilités avec Trivy.
    -   **Container Push** : Envoi de l'image vers Azure Container Registry (ACR).
    -   **Container Sign** : Signature de l'image avec Cosign (optionnel dans un premier temps, recommandé ensuite).

### Phase 2 : Pipeline d'Infrastructure (IaC) - Terraform
*Objectif : Valider et sécuriser le code d'infrastructure.*
1.  **Workflow GitHub Actions** (`.github/workflows/infra-ci.yml`) :
    -   **Terraform Format** (`terraform fmt`).
    -   **Terraform Validate**.
    -   **Security Scan (IaC)** : Integration de Checkov ou Terrascan pour détecter les mauvaises configurations.
    -   **Terraform Plan** : Génération du plan d'exécution (vérification des changements).

### Phase 3 : Déploiement Continu (CD)
*Objectif : Déployer automatiquement les changements validés.*
1.  **Workflow de Déploiement** (peut être intégré à la CI ou séparé) :
    -   **Authentification Azure** via OIDC (OpenID Connect) pour éviter les secrets statiques.
    -   **Terraform Apply** : Application des changements d'infrastructure (si nécessaire).
    -   **App Service Deploy** : Déploiement de la nouvelle image Docker sur Azure App Service.
    -   **Health Check** : Vérification que l'application répond correctement après déploiement.

### Phase 4 : Tests de Sécurité Dynamiques (DAST)
*Objectif : Tester l'application en cours d'exécution.*
1.  **Intégration OWASP ZAP** :
    -   Lancer un scan DAST sur l'environnement de staging/dev après déploiement.
    -   Remonter les alertes de sécurité critiques.

## 🛠 Outils & Technologies
-   **VCS** : GitHub
-   **CI/CD** : GitHub Actions
-   **IaC** : Terraform
-   **Security Scans** :
    -   SAST : CodeQL / SonarCloud
    -   Container : Trivy
    -   IaC : Checkov / Terrascan
    -   DAST : OWASP ZAP
-   **Signing** : Cosign
-   **Cloud** : Azure (App Service, ACR, Key Vault)

## 📅 Prochaines Étapes Immédiates
1.  Valider la copie des fichiers du Projet 1.
2.  Initialiser le dépôt Git local.
3.  Créer le premier workflow `.github/workflows/ci.yml` pour l'application.
