# Étape 2 : Scan de sécurité IaC avec Checkov

## Description
Sécuriser l'Infrastructure as Code (IaC) signifie scanner les fichiers de configuration *avant* leur déploiement. Dans cette étape, nous avons intégré **Checkov** au sein de notre pipeline GitHub Actions (`infra-ci.yml`) afin de réaliser une analyse statique (SAST - Static Application Security Testing) spécifiquement conçue pour Terraform.

Checkov analyse les configurations du dossier `terraform/` en s'appuyant sur des centaines de bonnes pratiques de sécurité cloud et des normes de conformité (telles que CIS, HIPAA, PCI-DSS).

## Correctifs appliqués
L'exécution de Checkov nous a permis d'identifier et de résoudre plusieurs failles de sécurité dans l'architecture initiale sans aucun coût Azure supplémentaire :
- **Réseau (Networking)** : Remplacement des règles permissives `0.0.0.0/0` sur le port HTTPS par un ciblage strict sur `Internet`. Plus de port Web 80 non sécurisé ouvert.
- **App Service** : Forçage du HTTPS, protocole HTTP/2, TLS 1.2 minimum, désactivation du FTP, et activation des diagnostics (logs).
- **Serveur SQL** : Forçage du TLS 1.2 minimum, intégration stricte d'un accès administrateur Azure AD (Entra ID), et retrait de règles firewall trop permissives.
- **Key Vault** : Activation de "Purge Protection" pour éviter la suppression accidentelle/malveillante des secrets, et mise en place de dates d'expiration pour la rétention et les mots de passe.

## Gestion des contraintes du Lab (`checkov:skip`)
Plusieurs bonnes pratiques de sécurité recommandent d'activer des fonctionnalités de niveau entreprise (ex: Private Endpoints, Géo-Redondance, et SKUs Premium). Ce projet étant un **Environnement Lab/Démo**, nous ne pouvons pas les activer car elles engendrent des coûts Azure significatifs (plusieurs centaines d'euros).

Au lieu de simplement désactiver le scanner, nous avons utilisé des commentaires sélectifs `checkov:skip`. C'est l'essence même d'une bonne approche DevSecOps : **L'acceptation du risque (Risk Acceptance)**. 
Nous prenons délibérément en compte une règle, et expliquons la raison de son contournement dans un contexte certifié (ex: `# checkov:skip=CKV_AZURE_222: "Private Endpoints are too expensive for this lab"`). Cela documente formellement les risques au cœur même de l'infrastructure de façon transparente, tout en gardant Checkov actif sur tout le reste de la plateforme (sans affecter la solidité de ses autres règles).
