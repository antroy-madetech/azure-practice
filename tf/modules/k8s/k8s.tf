provider "kubernetes" {
  # load_config_file = "false"
  host = var.host
  client_certificate = var.client_certificate
  client_key = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate
}

resource "kubernetes_deployment" "ants_test_deployment" {
  metadata {
    name = "ants-test"
    labels = {
      test = "AntsTest"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        test = "AntsTest"
      }
    }

    template {
      metadata {
        labels = {
          test = "AntsTest"
        }
      }

      spec {
        container {
          image = "nginx:1.7.8"
          name  = "ants-site"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/nginx_status"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "example" {
  metadata {
    name = "ants-test-service"
  }
  spec {
    selector = {
      test = "AntsTest"
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
