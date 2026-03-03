# Phase 4 : Tests de Sécurité Dynamiques (DAST)

## Objectif
Mettre en œuvre des tests de sécurité dynamiques (DAST) sur l'application en cours d'exécution à l'aide d'OWASP ZAP (Zed Attack Proxy). Cette phase permet de vérifier la posture de sécurité externe de l'application après son déploiement sur l'environnement cible (Azure App Service).

## Aperçu Structurel
Cette phase introduit des tests dynamiques continus intégrés nativement au pipeline de déploiement.

1. [**Étape 1 : Scan ZAP Baseline**](./01-owasp-zap/README_FR.md) *(Terminé)*

---

## Stack Technique
- **GitHub Actions** : Workflows automatisés d'analyse de vulnérabilités.
- **OWASP ZAP (Zed Attack Proxy)** : Scanner dynamique de sécurité des applications web.
- **Docker** : Exécution conteneurisée des outils ZAP et rapports.
- **Intégration GitHub Issues** : Création automatique de tickets pour remonter les vulnérabilités détectées.
