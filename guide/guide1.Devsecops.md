# GUIDE 1 - PROJET 2 DEVSECOPS

## Objectif
Industrialiser le Projet 1 avec une chaine CI/CD securisee et orientee production.

## Perimetre
- Build -> Test -> Scan -> Deploy
- Scan IaC (Terraform)
- SAST (analyse statique du code)
- DAST (scan dynamique applicatif)
- Scan image Docker (Trivy)
- Signature d'image (Cosign)
- OIDC pour eviter les secrets statiques

## Prerequis
- Projet 1 fonctionnel (infra Terraform + App Service)
- Repo GitHub avec Actions active
- Service principal OIDC configure dans Azure
- ACR disponible (ou a creer dans ce projet)

## Architecture cible (pipeline)
1. Validate:
- terraform fmt -check
- terraform validate
- tests unitaires app

2. Security scans:
- IaC: Checkov ou Terrascan
- SAST: CodeQL
- Image: Trivy
- DAST: OWASP ZAP sur environnement de test

3. Build and publish:
- build image Docker
- push image vers ACR
- signer image avec Cosign

4. Deploy:
- deploiement infra/app via workflow
- verification post-deploiement (healthcheck)

## Structure recommandee
- `.github/workflows/infra-deploy.yml`
- `.github/workflows/app-deploy.yml`
- `.github/workflows/security-scans.yml`
- `app/` (code applicatif)
- `terraform/` (infra)
- `docs/devsecops/` (preuves, rapports, decisions)

## Definition of Done (Projet 2)
- Pipeline complet execute automatiquement sur PR + main
- Rapports scans archives dans les artifacts GitHub
- Politique de blocage: merge refuse si scan critique
- Image signee et tracable (provenance)
- Documentation d'exploitation et remediations

## Plan de mise en oeuvre (ordre)
1. Creer `app-deploy.yml` (build/test/trivy/push/deploy)
2. Creer `security-scans.yml` (checkov + codeql + zap)
3. Ajouter Cosign (signature + verification)
4. Ajouter quality gates (fail sur severite high/critical)
5. Publier un tableau de suivi des vulnerabilites corrigees

## Livrables attendus
- YAML CI/CD complet
- Rapports de scans SAST/DAST/IaC/Image
- Diagramme de la supply chain
- README DevSecOps avec procedures de runbook

## Prochaine action recommandee
Commencer par `app-deploy.yml` avec: build, tests, trivy, push ACR, restart App Service.
