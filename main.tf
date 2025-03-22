resource "kubernetes_namespace" "example" {
  metadata {
    name = var.name
  }
}


resource "kubernetes_limit_range" "example" {
  metadata {
    name = "resource-limit"
    namespace = var.name
  }
  spec {
    limit {
      type = "Pod"
      max = {
        cpu    = "200m"
        memory = "1024Mi"
      }
    }
    limit {
      type = "PersistentVolumeClaim"
      min = {
        storage = "24M"
      }
    }
    limit {
      type = "Container"
      default = {
        cpu    = "50m"
        memory = "24Mi"
      }
    }
  }
}

resource "kubernetes_resource_quota" "example" {
  metadata {
    name = "terraform-example"
    namespace = var.name
  }
  spec {
    hard = {
      pods = 10
    }
    scopes = ["BestEffort"]
  }
}

