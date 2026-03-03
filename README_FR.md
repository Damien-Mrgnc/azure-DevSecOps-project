# Projet d'Industrialisation Cloud DevSecOps (Azure & GitHub Actions)

Bienvenue dans le projet d'industrialisation Cloud DevSecOps. Ce dépôt Github transforme une application web classique et son code d'infrastructure en une véritable usine logicielle sécurisée, hautement automatisée et résiliente.

L'architecture englobe la totalité du cycle de vie du logiciel, de la validation du code (Node.js) à l'infrastructure (Terraform) jusqu'au déploiement continu et l'analyse dynamique des vulnérabilités de production.

*Read the [English Version (Version Anglaise)](README.md) here.*

## Les Phases du Projet
L'évolution DevOps de ce projet de bout en bout est structurée logiquement en blocs techniques, avec une documentation locale étape par étape :

### [Phase 0 : Initialisation](./phase-0-initialisation/README_FR.md)
Le démarrage, incluant le nettoyage, la structuration, et l'établissement d'une identité "OIDC" sans mot de passe (Secret-less) entre GitHub Actions et Azure.

### [Phase 1 : Intégration Continue (App)](./phase-1-ci-app/README_FR.md)
Sécurisation et automatisation de l'empaquetage de l'application.
- Linting Node.js et Tests Unitaires.
- Scan statique du code source (SAST via SonarCloud).
- Build d'image Docker sécurisé, et push sur le registre privé Azure (ACR).
- Analyse comportementale anti-vulnérabilités des librairies de l'image (Trivy).
- Signature cryptographique des conteneurs pour garantir l'intégrité (Cosign/Sigstore).

### [Phase 2 : Intégration Continue (Infra)](./phase-2-ci-infra/README_FR.md)
Validation absolue de la qualité de l'Infrastructure as Code (Terraform).
- Formatage et Validation de syntaxe HCL (`fmt`/`validate`).
- Traque des failles cloud et des mauvaises configurations via Checkov.
- Plans d'intégration et détection de collision sur l'état distant Azure.

### [Phase 3 : Déploiement Continu (CD)](./phase-3-cd/README_FR.md)
Livraison automatisée transparente.
- Déploiement "Zero Touch" de la base de données, Vaults, et des Services App Terraform.
- Synchronisation Webhooks et configurations App Service à la volée.
- Tests continus de santé après chaque sortie avec annulation (Fail-Fast) au premier défaut.

### [Phase 4 : Tests de Sécurité Dynamiques (DAST)](./phase-4-dast/README_FR.md)
Boucle de Rétroaction en Production.
- Audits de pénétration post-déploiement "In The Wild" avec OWASP ZAP.
- Système de gestion de tickets Github piloté de façon dynamique (Les avertissements ouvrent des Issues).
- Génération d'artefacts et rapports de vulnérabilités pour chaque release.

---
## Stack Technique & DevSecOps
- **Stockage & CI-CD:** GitHub / GitHub Actions
- **Fournisseur Cloud:** Microsoft Azure
- **Infrastructure-as-Code:** Terraform
- **Application:** Node.js, Express, Docker
- **Scanners de Sécurité:** SonarCloud (SAST), Trivy (SCA), Checkov (IaC), OWASP ZAP (DAST)
