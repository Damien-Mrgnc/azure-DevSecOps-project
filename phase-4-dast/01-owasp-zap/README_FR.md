# Étape 1 : Scan ZAP Baseline

## But principal
Introduire des tests continus dynamiques (DAST) directement après le déploiement sur Azure à l'aide de l'action Github OWASP ZAP Baseline (`action-baseline@v0.14.0`). Ce processus garantit que les services en cours d'exécution disposent d'en-têtes HTTP sécurisés, de règles strictes pour les cookies, et d'une immunité face aux vulnérabilités web classiques.

## Fonctionnement
1. **Déclenchement CI/CD** : Suite au déploiement et au Health Check de l'application sur Azure, le job `dast` prend le relais.
2. **Isolation Docker** : Un conteneur ZAP audite l'URL `*.azurewebsites.net` via son "spider" pendant une durée paramétrable.
3. **Correctif de Permissions (Host/Docker)** : Ajustement des droits du Runner GitHub (`chmod 777`) pour permettre au conteneur ZAP d'écrire ses logs et ses rapports d'audit (comme `zap.yaml`) dans le workspace sans erreur `Permission Denied`.
4. **Issue Management & Artefacts** : 
    - L'argument `fail_action: false` permet au scan de terminer sans faire échouer brutalement le pipeline, favorisant l'analyse.
    - ZAP utilise l'API GitHub (permissions `issues: write`) pour créer un ticket détaillé (Issue) recensant l'ensemble de ses trouvailles (Warnings, Info).
    - Un rapport zippé contenant JSON, HTML, Markdown est finalisé et mis à disposition dans les Artifacts de l'Action.

## Résultats
- La WebApp montre d'excellents résultats de base (Aucun échec bloquant CRITICAL/FAIL).
- Les alertes "Warn" restantes mettent en avant la nécessité future d'un durcissement des en-têtes (Headers, CORS, CSP, Cookies HSTS) côté Node.js - de parfaits exemples de tickets injectables dans le backlog de dev !
