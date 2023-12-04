# GitHub self-hosted Runner Integration Templates

This repository provides source code for automating the set up and configuration of GitHub self-hosted runners running on Microsoft Azure. You can use the workflows and Terraform modules to setup a basic implementation in your repository. It is recommended for you to review the configuration in the modules and update them to meet your requirements. 

The purpose of the repository is to:

- Provide sample workflows for automating the deployment of self-hosted runners on GitHub repositories
- Demonstrate how to use self-hosted runners hosted on various Azure Compute Services

_Please note this repository is under development and subject to change._

## Repository structure

- `src` - All source code including Kubernetes manifests, Terraform modules and Helm charts.
  - `infra` - Terraform infrastructure code for basic landing zone, runner infrastructure and runners
    - `landing-zone` - Basic landing zone infrastructure for demonstrating how to integrate runners into architecture
    - `runner-infra` - Platform agnostic runner environment including resource group, VNET,and NSG
    - `runners` - Infra for the three supported runners: AKS, ACA, and Azure VMs
      - `aks` - Terraform module for deploying basic AKS cluster for runners
      - `container-apps` - Terraform module for deploying ACA environment for ACA Jobs
      - `vms` - Terraform module for deploying basic Virtual Machine for single runners
  - `manifests` - Manifests for AKS runners
    - `Charts` - Helm charts for AKS runners

## Getting Started
The goal of this repository is to provide samples of how to automate the setup, deployment and registration of self-hosted runners to a GitHub repository. If your project needs to be able to scale runners to workflow demand, it isn't cost effective or efficient to have several Virtual Machines constantly running waiting for jobs. Three Azure Compute options are demonstrated in this repository: Azure Virtual Machines, Azure Container Apps, and Azure Kubernetes Service. Each platform provides a different level of configuration management, scaling capabilities, and cost. You will first need to decide which platform makes the most sense for your project and then identify whether you want those runners to be hosted on your existing architecture or be hosted in a separately managed environment.  

### Choose your platform
1. [Azure Virtual Machines](https://learn.microsoft.com/azure/virtual-machines/)
   1. Good option for when you have a smaller job demand, are testing self-hosted runners, or have a pre-configured VM that you'd like to use
   2. Tend to be more expensive than other compute options
2. [Azure Container Apps (ACA)](https://learn.microsoft.com/azure/container-apps/)
   1. [ACA Jobs](https://learn.microsoft.com/azure/container-apps/jobs?tabs=azure-cli) are very easy to scale, configure and manage
   2. Ability to configure auto-scaling, container image, physical memory constraints, and more all in the CLI command to deploy the ACA job
   3. This is a good option for easy and cost effective auto-scaling
   4. ACA only supports Linux jobs. 
3. [Azure Kubernetes Service (AKS)](https://learn.microsoft.com/en-us/azure/aks/)
   1. Highly customizable service that allows you to have full control over runners configuration and management
   2. Supports Linux and Windows nodepools within the same cluster
   3. Can have one or multiple runner deployments using different container images or different OS
   4. Utilizes [Actions Runner Controller](https://github.com/actions/actions-runner-controller/tree/master) to handle auto-scaling using [webhooks (example shown in this repository)](https://github.com/actions/actions-runner-controller/blob/master/docs/automatically-scaling-runners.md#webhook-driven-scaling) or [pull driven auto-scaling](https://github.com/actions/actions-runner-controller/blob/master/docs/automatically-scaling-runners.md#pull-driven-scaling). 

### Choose your deployment model

#### [Standalone](.github/workflows/)

The standalone model is a GitHub workflow that is run and managed separately from your application or project workflows. It sets up an environment for the self-hosted runners such as a resource group, virtual network, network security groups, etc., deploys the runners and registers them with the repository. The runners are hosted on their own virtual network separate from your application infrastructure. 

This option works best if you want your runners to be completely separate from your application or project infrastructure or the runners need to be managed separately. If you have a privatized architecture for your application, you would then be required to enable virtual network peering and the necessary permissions for your infrastructure deployments to run on those self-hosted runners. 

##### Pre-requisites

- An active Azure subscription
- Contributor at the Azure subscription level
- An Azure Storage Account for maintaining Terraform state. Configuring Terraform State Storage has been omitted for brevity

:arrow_forward: [Get Started](.github/workflows/README.md)

#### [Integrated](.github/workflows/)

The integrated model makes use of your existing application or project infrastructure by deploying the runners on a pre-existing subnet in a virtual network in your application or project infrastructure. This requires you to integrate the steps for deploying, managing and updating the runners into your application or project deployment strategy. This works well if you have a privatized architecture and removes the need for adding peering and additional permissions. 

Example workflows are not explicitly provided for these scenarios because the same steps will be used for deployment as the standalone version with the exception of passing in a subnet ID for a Virtual Machine deployment. See [Special Considerations](.github/workflows/README.md) for additional information. 

##### Pre-requisites

- An active Azure subscription
- Contributor at the Azure subscription level or at the Resource Group level for your existing infrastructure
- The subnet for the runners needs to be a sufficient size to support the deployment and auto-scaling
- The DNS for the runners must be publicly resolvable unless you are using a GitHub repository hosted on your private network
  
:arrow_forward: [Get Started](.github/workflows/README.md)