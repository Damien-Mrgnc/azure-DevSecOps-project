# Étape 3 : Vérification de Santé (Health Check) Post-Déploiement

## Concept
Un pipeline de déploiement qui signale "Succès" simplement parce que les fichiers ont été envoyés est incomplet. L'application en elle-même doit fonctionner, le serveur web doit tourner de manière dynamique, et les points de terminaison de l'API (Endpoints) doivent répondre correctement dans l'écosystème de production réel.

## Détails d'Implémentation
Un script de sonde (Health Check) a été ajouté directement à l'intérieur du job `deploy` en bash et en utilisant `curl` pour attaquer agressivement la réponse `/api/config`. Ce script patiente pendant le démarrage du conteneur et gère les échecs de timeout de démarrage HTTP avec une boucle de répétitions intelligentes.

### Considérations Entra ID "Easy Auth"
Puisque Microsoft Azure force Microsoft Entra ID de manière native sur l'App Service avant l'accès au serveur Express.js :
1. Une requête `cURL` retourne toujours un blocage `401 Unauthorized` si elle n'est pas authentifiée de base.
2. Une réponse `401 HTTP` garantit donc formellement que la stack applicative est "UP", démarée, et évalue correctement les entêtes d'une requête HTTP.
3. Si le conteneur Docker crashait, une Gateway Azure Azure nous répondrait plutôt par `502 Bad Gateway` ou `503 Service Unavailable`.
4. Évidemment, la logique veut que, les codes `200 OK` ET `401 Unauthorized` soient évalués par notre script comme des réussites totales de Santé applicative !

### Exemple d'implémentation Bash :
```bash
STATUS=$(curl -s -o /dev/null -w '%{http_code}' https://app-projet1-1665c35a.azurewebsites.net/api/config)
if [ "$STATUS" -eq 200 ] || [ "$STATUS" -eq 401 ]; then
  echo "Health check passed!"
  exit 0
fi
```
