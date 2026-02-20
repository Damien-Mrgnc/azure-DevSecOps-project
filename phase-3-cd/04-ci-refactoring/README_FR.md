# Étape 4 : Refactoring Granulaire CI/CD

## Concept
À mesure que la complexité des fonctionnalités CI/CD grandit en entreprise, le maintien de longs pipelines ("Monolithe Jobs") dégrade considérablement l'observabilité. Si un pipeline échoue, cibler avec exactitude quand ou comment (L'Analyse Statique ? Une livraison Docker ?) devient très difficile sans fouiller aléatoirement les consoles de logs.

## Détails d'Implémentation
Les deux fichiers `.github/workflows` (`app-ci.yml` et `infra-ci.yml`) ont été soigneusement démantelés et éclatés en multiples jobs indépendants, discrets, et interdépendants.

### Dissection du Pipeline Application 
Transformation de 3 grands Jobs en 7 tâches individuelles :
1. `lint` (Nettoyage de code)
2. `test` (Tests Unitaires)
3. `sast` (SonarCloud)
4. `build-and-push` (Ne démarre UNIQUEMENT qu'après `[lint, test, sast]`)
5. `container-scan` (Trivy)
6. `container-sign` (Cosign)
7. `deploy` (La nouvelle étape Serveur)

### Dissection du Pipeline Infrastructure 
Transformation des Jobs massifs en étapes Terraform logiques et précises :
1. `terraform-fmt`
2. `terraform-validate`
3. `security-scan` (Checkov)
4. `terraform-plan`
5. `terraform-apply`

Maintenant sur GitHub, chaque job dispose d'un environnement unilatéral, des scopes explicites, un map `needs` qui exploite parallèlement les Runners GitHub Actions, et des indicateurs de statut discrets facilitant une observabilité exceptionnelle (DevSecOps native).
