variable "resourceGroupName" {
  type = string
}
  
variable "location" {
  default = "eastus"
}

variable "acrName" {
  type = string
  default = "containerAppsAcr"
}

variable "tags" {
  default = {}
}

variable "logAnalyticsWorkspaceName" {
  type = string
  default = "containerAppsLaw"
}

variable "containerAppsEnvironmentName" {
  type = string
  default = "githubRunnersCAE"
}