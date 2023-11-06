variable "selfHostedRunnerName" {
  type = string
}

variable "location" {
  type = string
  default = "eastus"
}

variable "stateSaContainerName" {
  type = string
  default = "tfstate"
}

variable "stateSaName" {
  type = string
}

variable "stateSaRg" {
  type = string
}

variable "sshKey" {
  type = string
  sensitive = true
}

variable "adminUsername" {
  type = string
  default = "azureuser"
}

variable "size" {
  type = string
  default = "Standard_DS2_v2"
}

variable "selfHostedRunnerToken" {
  type = string
  sensitive = true
}

variable "githubRepoUrl" {
  type = string
}
