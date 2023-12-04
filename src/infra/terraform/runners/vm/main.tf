data "terraform_remote_state" "environment" {
  backend = "azurerm"

  config = {
    storage_account_name = var.stateSaName
    container_name       = var.stateSaContainerName
    key                  = "environment.tfstate"
    resource_group_name  = var.stateSaRg
  }
}

resource "azurerm_network_interface" "githubRunnerNic" {
  name                = "runnerNic"
  location            = data.terraform_remote_state.environment.outputs.location
  resource_group_name = data.terraform_remote_state.environment.outputs.resourceGroupName

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.terraform_remote_state.environment.outputs.runnerSubnetId
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "githubRunnerVm" {
  resource_group_name = data.terraform_remote_state.environment.outputs.resourceGroupName
  name                = var.selfHostedRunnerName
  location = data.terraform_remote_state.environment.outputs.location
  size = var.size
  admin_username = var.adminUsername
  network_interface_ids = [ azurerm_network_interface.githubRunnerNic.id ]

  custom_data = base64encode(templatefile("cloud-init.yaml", {
    githubRepoUrl = var.githubRepoUrl
    selfHostedRunnerToken = var.selfHostedRunnerToken
    runnerPlatform = var.runnerPlatform
    runnerArch = var.runnerArch
    latestVersion = var.runnerVersion
  }))

  admin_ssh_key {
    username = var.adminUsername
    public_key = file(var.sshKey)
  }

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts"
    version = "latest"
  }
}