# Étape 2 : Déploiement Docker sur App Service

## Concept
Une fois que les artefacts de l'application (le conteneur Docker) sont compilés, vérifiés pour la sécurité via des outils (SCA), signés de manière persistante, et expédiés vers un registre privé (ACR), l'environnement de déploiement doit automatiquement être notifié d'une mise à jour de l'image.

## Détails d'Implémentation
Le job `deploy` orchestre la récupération de la nouvelle image pour la déployer sur les slots du conteneur App Service cible.

### Fonctionnalités
1. **Azure Web Apps Action** : Utilise l'action `azure/webapps-deploy@v2` en ciblant les conventions de nommage structurelles générées par les étapes IaC (Terraform) précédentes.
2. **Référencement Dynamique** : Mappe `images: 'acr.../runtime-governance-app:${{ github.sha }}'` sécurisant le hachage cryptographique identique du code fusionné via la logique du SHA du "commit".
3. **Ségrégation de l'Environnement** : Repose sur des secrets GitHub spécifiques et des permissions d'écriture de l'ID Token (`id-token: write`) pour se connecter de manière très sécurisée via la fédération Azure OIDC sur l'App Service en question.

### Impact
Rotation d'image (Zero-Downtime) propre et orchestrée depuis le contrôle de version garantissant que les fusions (merges) CI affectent activement le nœud cloud en production.
