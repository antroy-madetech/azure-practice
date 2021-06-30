provider "azurerm" {
  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id

  features {}
}

module "cluster" {
  source = "./modules/cluster/"
  client_id = var.client_id
  client_secret = var.client_secret
  ssh_key = var.ssh_key
  location = var.location
  kubernetes_version = var.kubernetes_version
}
