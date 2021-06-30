  variable "client_id" {}
  variable "client_secret" {}
  variable "ssh_key" { }
  variable "location" {
    default = "uksouth"
  }
  variable "kubernetes_version" {
    default = "1.16.10"
  }
