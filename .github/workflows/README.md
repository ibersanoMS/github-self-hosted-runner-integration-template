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

### Instructions
1. After you've set up the required GitHub Secrets and Variables, navigate to the Actions tab in your GitHub repository and locate your desired platform workflow that has Standalone in the name.
2. Run the workflow
3. After the workflow has successfully deployed, locate the test workflow in the Actions tab. Run that workflow to see your runners scale and/or run a job successfully. 
   [!NOTE] For AKS Standalone, you need to add the webhook URL to your repository in order for your runners to receive new job requests. Navigate to Settings then Webhooks in your repository. If not using your own custom domain like the example in the example in this repository, use the following settings:
      - Payload URL: [Your DNS Label].[Deployment Location].cloudapp.azure.com/actions-runner-controller-github-webhook-server
      - Content type: application/json
      - Which events would you like to trigger this webhook? 
        - Let me select individual events 
          - Workflow jobs
      - Select *Active* 
# Integrated Deployment

To integrate the deployment steps for your runners into your existing architecture, it is assumed that you have your state store configured and a service principal is available for use similar to the configuration for the standalone scenario above. You would need to take the steps from the standalone deployment and put them into your existing workflow deployment or put them into a reusable workflow to call from your existing deployment. See example below.

## Special Considerations
### Virtual Machines
The example module for deploying a Virtual Machine runner in this repo retrieves the subnet id for the NIC from the runner environment's state store since it is also deployed using Terraform. You could keep this as is and pass in your state file name. An alternative would be to have a variable assignment to the subnet id to pass in the value.