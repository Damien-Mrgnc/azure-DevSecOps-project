# Runtime Governance App

## Description
This is a dynamic governance application built with Node.js 20, Express, Prisma, and Azure SQL. It allows modifying site behavior via an administration interface without redeployment, maintaining a full audit trail.

## Key Features
*   **Dynamic Display**: Configurable title, description, theme, and maintenance mode in real-time.
*   **Admin API**: Protected endpoint for configuration updates.
*   **Security**: Uses Managed Identity for SQL database connection and Key Vault secret access.
*   **Observability**: Structured JSON logging for Azure Monitor ingestion.

## Technical Architecture
*   `src/api`: REST route definitions.
*   `src/services`: Business logic (Configuration, Key Vault).
*   `src/middleware`: Authentication and Logging.
*   `src/views`: User Interface (Server-Side Rendering with EJS).
*   `prisma`: SQL Server database schema and migrations.

## Azure Prerequisites
The application requires the following Azure resources:
*   Azure App Service (Linux Container).
*   Azure SQL Database.
*   Azure Key Vault.
*   Managed Identity enabled on the App Service with appropriate roles (`Key Vault Secrets User`).

## Local Development
To run the application locally via Docker:
1.  Copy `.env.example` to `.env`.
2.  Start the local database: `docker-compose up -d db`.
3.  Install dependencies: `npm install`.
4.  Apply migrations: `npx prisma migrate dev`.
5.  Start the development server: `npm run dev`.

## Azure Deployment
Deployment is automated via GitHub Actions:
1.  Build Docker image and push to Azure Container Registry (ACR).
2.  Deploy the image to App Service.

### Environment Variables
*   `DATABASE_URL`: Database connection string (MSI authentication).
*   `KEY_VAULT_URL`: URL of the Azure Key Vault instance.
*   `NODE_ENV`: `production`.
*   `PORT`: `8080`.
