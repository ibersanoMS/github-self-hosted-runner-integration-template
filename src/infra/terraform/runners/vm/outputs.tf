output "vmName" {
  value = azurerm_linux_virtual_machine.githubRunnerVm.name
}

output "resourceGroupName" {
    value = azurerm_linux_virtual_machine.githubRunnerVm.resource_group_name
}