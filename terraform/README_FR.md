# Infrastructure as Code (Terraform)

## Description
Ce dossier contient l'ensemble des manifestes Terraform nécessaires au déploiement de l'infrastructure sur Microsoft Azure. L'architecture est modulaire et suit les meilleures pratiques de sécurité et de maintenance.

**Note sur la sécurité et les coûts (Mode Lab) :**
Certaines fonctionnalités de sécurité de niveau entreprise (Private Endpoints, ACR Premium, Redondance de zone SQL, Évaluation des vulnérabilités) sont intentionnellement désactivées en mode LAB afin de maintenir les coûts Azure au minimum. Une configuration prête pour la production est disponible via des feature flags.

## Structure des Fichiers
L'infrastructure est découpée logiquement :

*   `main.tf` : Configuration principale, définition du Provider Azure.
*   `compute.tf` : Définition de l'App Service Plan et de l'Azure App Service (Linux).
*   `database.tf` : Configuration du serveur Azure SQL et de la base de données.
*   `network.tf` : Création du Virtual Network (VNet), des sous-réseaux (Public/Privé) et des Network Security Groups (NSG).
*   `security.tf` : Configuration d'Azure Key Vault et des politiques d'accès (Access Policies).
*   `monitoring.tf` : Infrastructure d'observabilité (Log Analytics Workspace, Application Insights).
*   `alerts.tf` : Définition des groupes d'actions et des règles d'alertes (CPU, Disponibilité).
*   `registry.tf` : Configuration de l'Azure Container Registry (ACR).
*   `variables.tf` : Déclaration des variables d'entrée.
*   `outputs.tf` : Définition des valeurs de sortie (URLs, IDs).

## Utilisation
Pour déployer l'infrastructure :

1.  Initialiser Terraform :
    ```bash
    terraform init
    ```

2.  Visualiser le plan d'exécution :
    ```bash
    terraform plan
    ```

3.  Appliquer les changements :
    ```bash
    terraform apply
    ```
