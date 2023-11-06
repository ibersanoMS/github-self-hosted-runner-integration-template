# Standalone Deployment 

## Required GitHub Secrets and Variables
### Secrets
- GH_PAT: GitHub Personal Access Token to give the workflow the ability to request a registration token for the runner from the GitHub API
  - **Required Permissions**: admin:org, repo
- AZURE_CLIENT_ID: Client Id of Azure Service Principal 
- AZURE_SUBSCRIPTION_ID: Your Azure Subscription Id
- AZURE_TENANT_ID: Your Azure Tenant Id
### Variables
- STATE_RESOURCE_GROUP_NAME: The resource group where your Terraform State Store lives
- STORAGE_ACCOUNT_NAME: The name of the Storage Account for your Terraform State Store
