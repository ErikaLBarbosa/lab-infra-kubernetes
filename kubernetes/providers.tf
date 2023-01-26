provider "kubernetes" {
  config_path = local_file.kubeconfig.filename
}

terraform {
  required_providers {
    remote = {
    source = "tenstad/remote" }
  }
}