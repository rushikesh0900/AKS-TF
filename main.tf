# Define the required provider
provider "azurerm" {
  features {}
}

# Resource group
resource "azurerm_resource_group" "rg" {
  name     = "aks-small-cost-rg"
  location = "East US"
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "aks-small-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "aks-small-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Subnet delegation to AKS
resource "azurerm_subnet_delegation" "aks" {
  name = "aks-delegation"
  service_delegation {
    name = "Microsoft.ContainerService/managedClusters"
    actions = [
      "Microsoft.Network/virtualNetworks/subnets/join/action",
    ]
  }

  subnet_id = azurerm_subnet.subnet.id
}

# Key Vault
resource "azurerm_key_vault" "kv" {
  name                = "aks-small-kv"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}

# Kubernetes Cluster (AKS)
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-small-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "akssmall"

  default_node_pool {
    name       = "nodepool1"
    node_count = 1
    vm_size    = "Standard_B2s" # Cost-effective VM size
    vnet_subnet_id = azurerm_subnet.subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

network_profile {
  network_plugin    = "azure"
  service_cidr      = "10.0.2.0/24"
  dns_service_ip    = "10.0.2.10"
}
}

# Output values
output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "key_vault_name" {
  value = azurerm_key_vault.kv.name
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}
