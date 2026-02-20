# Phase 2 : Pipeline d'Intégration Continue (CI) - Infrastructure as Code (IaC)

## Objectif
Mettre en place un pipeline d'intégration continue robuste, spécifiquement pour l'infrastructure as code (Terraform). Ce pipeline valide la syntaxe de l'infrastructure Azure, déploie les plans d'exécution et applique strictement les standards de sécurité grâce à des outils d'analyse statique avancés. L'objectif est d'empêcher les mauvaises configurations (ex: bases de données exposées, Key Vaults non chiffrés) d'atteindre les environnements de staging ou de production.

## Architecture de la Phase
Cette phase introduit la méthodologie GitFlow et intègre des scanners de sécurité spécialisés pour l'IaC.

0. [**Étape 0 : Adoption de la méthodologie GitFlow**](./00-gitflow-methodology/README_FR.md) *(Terminé)*
1. [**Étape 1 : Formatage et Linting Terraform**](./01-lint-format/README_FR.md) *(Terminé)*
2. [**Étape 2 : Scan de sécurité IaC avec Checkov/Terrascan**](./02-security-scan/README_FR.md) *(Terminé)*
3. [**Étape 3 : Exécution de Terraform Plan**](./03-terraform-plan/README_FR.md) *(Terminé)*

---

## Stack Technique
- **GitHub Actions** : Orchestration du pipeline CI pour l'infrastructure (YAML).
- **Terraform CLI** : Formatage natif (`fmt`) et validation syntaxique (`validate`).
- **Checkov** : Tests de sécurité applicatifs statiques (SAST) avancés, spécialisés pour les configurations d'infrastructure.
- **Azure CLI / OIDC** : Base d'authentification sécurisée, sans secrets, indispensable pour la génération de plans sur l'état d'Azure.
