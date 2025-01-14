# Resource Group
variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "aks-small-cost-rg"
}

variable "location" {
  description = "Azure region for the resources"
  default     = "East US"
}

# Virtual Network
variable "vnet_name" {
  description = "The name of the virtual network"
  default     = "aks-small-vnet"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  default     = ["10.0.0.0/16"]
}

# Subnet
variable "subnet_name" {
  description = "The name of the subnet"
  default     = "aks-small-subnet"
}

variable "subnet_address_prefix" {
  description = "Address prefix for the subnet"
  default     = ["10.0.1.0/24"]
}

# AKS Cluster
variable "aks_name" {
  description = "The name of the AKS cluster"
  default     = "aks-small-cluster"
}

variable "node_count" {
  description = "Number of nodes in the AKS cluster"
  default     = 1
}

variable "node_vm_size" {
  description = "VM size for the nodes in the AKS cluster"
  default     = "Standard_B2s"
}

# Key Vault
variable "key_vault_name" {
  description = "The name of the Azure Key Vault"
  default     = "aks-small-kv"
}
