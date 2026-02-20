# Étape 1 : Terraform Apply Automatisé

## Concept
Les modifications d'infrastructure doivent être planifiées automatiquement à chaque "pull request", mais seulement appliquées de manière automatique lors de la fusion (merge) sur la branche protégée `main`. C'est ce qu'on appelle l'approche "GitOps" ou "Shift-Left IaC", garantissant que la branche de suivi est toujours équivalente à l'architecture cloud déployée.

## Détails d'Implémentation
Un nouveau job `terraform-apply` a été ajouté au workflow `.github/workflows/infra-ci.yml`.

### Directives Clés
1. **Validation d'Environnement** : Contient la condition `if: github.ref == 'refs/heads/main' && github.event_name == 'push'` avant l'exécution.
2. **Dépendance de Pipeline** : Configuré avec `needs: terraform-plan`, s'assurant qu'un plan d'exécution est construit avec succès avant toute altération de l'infra.
3. **Exécution Non Assistée** : Exécute `terraform apply -auto-approve -lock=false` résolvant les demandes d'autorisation manuelles habituellement requises par un ingénieur en local.
4. **Contexte d'Environnement** : Défini avec `environment: production`, le rattachant aux politiques de déploiement de GitHub et aux secrets spécifiques de cette sphère.

### Résultat
Toute configuration non validée poussée via des chemins non approuvés passera "skip" l'application, protégeant ainsi l'App Service et les niveaux de base de données de pannes structurelles non intentionnelles.
