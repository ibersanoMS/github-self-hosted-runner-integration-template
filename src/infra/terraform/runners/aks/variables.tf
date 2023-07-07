variable "clusterName" {
  type = string
  default = "github-runners"
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

