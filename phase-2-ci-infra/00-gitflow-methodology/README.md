# Étape 0 : Adoption de la Méthodologie GitFlow (Feature Branching)

## Pourquoi ce changement ?
Durant la **Phase 1** (Construction du pipeline applicatif), nous avons adopté une approche de développement direct sur la branche principale (`main`). Cette méthode, bien qu'efficace pour rapidement bootstraper le projet initial de A à Z seul, ne représente pas l'état de l'art du travail collaboratif.

À partir de cette **Phase 2 (Infrastructure as Code - Terraform)**, nous "passons à la vitesse supérieure" en adoptant les standards stricts du **DevSecOps** et du travail d'équipe en implémentant le workflow **GitFlow** (plus spécifiquement le Feature Branching Workflow via GitHub).

## La Méthodologie "Feature Branching"

La règle d'or est désormais la suivante : **Il est formellement interdit de pousser (push) directement du code sur la branche `main`**. La branche `main` représente la Production. Si elle casse, le système tombe.

### Cycle de vie d'une fonctionnalité DevSecOps :
1. **Création d'une branche de travail (Feature Branch)** :
   Pour chaque nouvelle tâche, une branche jetable et isolée est créée depuis `main`.
   ```bash
   git checkout -b feat/nom-de-la-tache
   ```
2. **Développement et Sécurisation locale** :
   Le développeur (ou l'ingénieur Cloud) code, teste et déploie en local sans impacter le reste de l'équipe.
3. **Pousse sur la branche distante** :
   ```bash
   git push origin feat/nom-de-la-tache
   ```
4. **Ouverture d'une Pull Request (PR)** :
   Une demande de fusion (Pull Request) est créée sur GitHub pour proposer l'intégration de la nouvelle fonctionnalité dans le `main`.
5. **Déclenchement des Pipelines CI (La Garde DevSecOps)** :
   C'est ici que l'automatisation prend tout son sens. GitHub Actions détecte la Pull Request et déclenche :
   - Le Linting (Format du code).
   - Les tests unitaires.
   - Le scan de sécurité SAST (SonarCloud, Checkov pour l'IaC).
   - *Si une erreur de sécurité est détectée, la Pull Request est automatiquement bloquée.*
6. **Code Review & Merge** :
   Si le pipeline CI passe au vert, un autre ingénieur effectue une revue de code (Code Review). Une fois approuvée, la Pull Request est fusionnée (Merged) dans `main`.

## Avantages pour ce Projet DevSecOps
- **Sécurité et Qualité** : Aucun code vulnérable ne peut atteindre la production sans avoir affronté les scanners (Trivy, SonarCloud, Checkov) dans un environnement isolé (la Pull Request).
- **Tracabilité** : Chaque modification de l'infrastructure Cloud ou de l'application est documentée, justifiée par une Request, et signée (Cosign).
- **Rollback** : En cas d'incident, il est extrêmement simple de "Revert" (annuler) le commit responsable d'une Pull Request défaillante.

*La création de ce document marque le début officiel de cette nouvelle charte de travail sur le dépôt, initialisée via la branche `feat/phase2-infra-ci`.*
