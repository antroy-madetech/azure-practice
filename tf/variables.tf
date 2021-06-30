  variable "subscription_id" {}
  variable "client_id" {}
  variable "client_secret" {}
  variable "tenant_id" {}
  variable "ssh_key" {}
  variable "location" {
    default = "uksouth"
  }
  variable "kubernetes_version" {
    default = "1.21.1"
  }
