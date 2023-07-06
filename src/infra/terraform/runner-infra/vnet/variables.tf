variable "vnetName" {
  description = "The name of the virtual network"
  type        = string
  default     = "slef-hosted-runner-vnet"
}

variable "vnetAddressSpace" {
  
}

variable "resourceGroupName" {
  type = string
  default = "github-self-hosted-runners"
}

variable "location" {
  type = string
  default = "eastus"
}

variable "subnetName" {
  type = string
  default = "runner-subnet"
}

variable "subnetAddressSpace" {
  type = string
}

variable "tags" {
  default = {}
}