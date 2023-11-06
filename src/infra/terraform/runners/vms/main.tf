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

  admin_ssh_key {
    username = var.adminUsername
    public_key = var.sshKey
  }

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "22_04-lts"
    version = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "registerRunner" {
  name                 = "registerRunner"
  virtual_machine_id   = azurerm_linux_virtual_machine.githubRunnerVm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
 {
    "script": "mkdir actions-runner && cd actions-runner\n curl -o actions-runner-linux-x64-2.311.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz\n echo \"29fc8cf2dab4c195bb147384e7e2c94cfd4d4022c793b346a6175435265aa278  actions-runner-linux-x64-2.311.0.tar.gz\" | shasum -a 256 -c\n tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz\n ./config.sh --url ${var.githubRepoUrl} --token ${var.selfHostedRunnerToken}\n ./run.sh"
 }
SETTINGS


  tags = {
    environment = "Production"
  }
}