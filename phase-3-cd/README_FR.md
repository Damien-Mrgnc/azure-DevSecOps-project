# Phase 3 : Pipeline de Déploiement Continu (CD)

## Objectif
Mettre en place un pipeline de déploiement continu robuste pour l'Infrastructure as Code (Terraform) et l'Application (Docker). Cette phase automatise la promotion des changements validés vers l'environnement de production Azure, garantissant des déploiements "zero-touch" combinés à des conditions de pré-déploiement strictes et des vérifications post-déploiement.

## Aperçu Structurel
Cette phase introduit des barrières de déploiement basées sur les branches Git et des vérifications de santé opérationnelles (health checks).

1. [**Étape 1 : Terraform Apply Automatisé**](./01-terraform-apply/README_FR.md) *(Terminé)*
2. [**Étape 2 : Déploiement Docker sur App Service**](./02-app-service-deploy/README_FR.md) *(Terminé)*
3. [**Étape 3 : Vérification de Santé Post-Déploiement (Health Check)**](./03-health-check/README_FR.md) *(Terminé)*
4. [**Étape 4 : Refactoring Granulaire CI/CD**](./04-ci-refactoring/README_FR.md) *(Terminé)*

---

## Stack Technique
- **GitHub Actions** : Environnements et barrières de déploiement (Environments gating).
- **Terraform CLI** : Provisionnement d'infrastructure automatisé et sans intervention (`apply -auto-approve`).
- **Azure App Service** : Plateforme d'hébergement de conteneurs Linux.
- **cURL / Bash** : Sondages de santé HTTP dynamiques.
- **Microsoft Entra ID (OIDC)** : Validation et gestion de l'interception Easy Auth.
