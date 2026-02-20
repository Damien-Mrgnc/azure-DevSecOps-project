# Étape 3 : Exécution de Terraform Plan

## Description
L'étape ultime de la validation de notre architecture avant son déploiement se résume à `terraform plan`. Cette instruction opère à un contrôle à blanc (dry-run) vis-à-vis des modifications apportées localement avec nos fichiers. Elle scrute l'authentification et l'état des dépendances en s'amorçant sur l'existant Microsoft Azure, et met le tout en opposition pour en dégager les potentielles brèches et changements de configuration.

## L'authentification par Azure OIDC
Le pipeline se relie de manière hautement sécurisée aux fondations Azure au travers de l'action `azure/login` qui utilise comme jeton l'autorisation stricte, dite de "moindre privilège" (`id-token: write`). Cet accréditement procure la légitimité pour Terraform d'aller interroger les informations de ressources d'état backend depuis un blob d'un Compte de Stockage (Storage Account), en évinçant complètement l'utilisation en dur du moindre code secret.

## Bénéfices visés par l'approche DevSecOps
- **Prévisibilité** : Déclaration transparente et évidente exposant aux architectes quelles portions d'Azure vont subir une élévation, un abaissement, une destruction ou une restructuration en amont.
- **Vision Économique** : (Pour intégration potentielle sur d'autres outils annexes typés Infracost). C'est le baromètre déterminant une prévision d'ajustement du budget Cloud de l'entreprise lors du changement induit par Terraform.
- **Rétro-verrouillage** : L'étape de Plan échoue de manière anticipée si elle rencontre des inter-conflits à propos des normes et identifiants IAM, si des dépendances bouclent sur elles-mêmes ou si le déploiement technique s'avère impossible matériellement. Cela crée un filtre définitif contre l'apparition d'un bloc de code corrompu ou vulnérable en production.
