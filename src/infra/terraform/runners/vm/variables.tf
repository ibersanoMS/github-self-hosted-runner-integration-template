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
  default = "~/.ssh/id_rsa.pub"
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

variable "adminPassword" {
  type = string
  sensitive = true
}

variable "runnerPlatform" {
  type = string
  default = "linux"
}

variable "runnerArch" {
  type = string
  default = "x64"
}

variable "runnerVersion" {
  type = string
  default = "2.311.0"
}