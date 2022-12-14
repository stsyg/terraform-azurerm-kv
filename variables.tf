variable "prefix" {
  type        = string
  description = "Prefix used in Azure resources naming convention"
}

variable "service" {
  type        = string
  description = "Service name used in Azure resources naming convention"
}

variable "location" {
  type        = string
  description = "Location name used in Azure resources naming convention"
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags to add to deployed resources"
}
