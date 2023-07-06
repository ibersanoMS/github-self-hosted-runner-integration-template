variable "vnetName" {
  default = "github-runners-vnet"
}

variable "vnetAddressSpace" {
  default = "10.0.0.0/16"
}

variable "subnetName" {
  default = "runner-subnet"
}

variable "subnetAddressSpace" {
  default = "10.0.1.0/24"
}

variable "location" {
  default = "eastus"
}

variable "nsgName" {
  default = "github-runners-nsg"
}

variable "tags" {
  default = {}
}

variable "resourceGroupName" {
  default = "github-runners"
}