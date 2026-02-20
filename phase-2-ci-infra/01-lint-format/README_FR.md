# Étape 1 : Formatage et Linting Terraform

## Description
Établir un standard de code commun est la première étape pour garantir la fiabilité de l'Infrastructure as Code.
En exécutant et en forçant `terraform fmt -check -recursive` dans le pipeline CI/CD, nous garantissons de manière procédurale que tout le code soumis respecte les directives de formatage universelles de HashiCorp.

De plus, la commande `terraform validate` s'exécute à chaque commit. Elle vérifie la syntaxe, la structure des blocs et les dépendances sans faire appel aux API du cloud ou sans consulter les données de l'état (state). Cela sert de filet de sécurité pour attraper les fautes de frappe ou les paramètres manquants avant que les scanners avancés ne prennent le relais.

## Détails techniques
- **Commandes utilisées** : `terraform fmt`, `terraform init -backend=false`, et `terraform validate`.
- **Position dans le pipeline** : `infra-ci.yml` (S'exécute en premier, avant les scans de sécurité).
- **Règle d'application** : Le pipeline est bloqué (erreur fatale) si la validation ou le formatage échouent, assurant ainsi qu'aucun code HCL malformé n'atteigne la branche principale.
