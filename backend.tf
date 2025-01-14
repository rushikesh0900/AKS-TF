terraform {
  backend "azurerm" {
    resource_group_name  = "Devops-RG"
    storage_account_name = "storageforterraform11"
    container_name       = "azureaksstorage"
    key                  = "backend.tf"
  }
}