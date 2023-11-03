# GitHub Self-hosted Runner Integration Templates

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
The goal of this repository is to provide samples of how to automate the setup, deployment and registration of self-hosted runners to a GitHub repository. If your project needs to be able to scale runners to workflow demand, it isn't cost effective or efficient to several Virtual Machines constantly running waiting for jobs. Three Azure Compute options are demonstrated in this repository: Azure Virtual Machines, Azure Container Apps, and Azure Kubernetes Service. Each platform provides a different level of configuration management, scaling capabilities, and cost. You will first need to decide which platform makes the most sense for your project and then identify whether you want those runners to be hosted on your existing architecture or be hosted in a separately managed environment.  

### Choose your platform
1. Azure Virtual Machines
2. Azure Container Apps
3. Azure Kubernetes Service

### Choose your deployment model
1. Integrated
2. Standalone

Configuring Terraform State Storage has been omitted for brevity

