# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}
# Configure the Azure provider
provider "azurerm" {
  features {}

  # Use Azure CLI authentication (in pipelines, this will use the service connection)
  use_msi = true
}
