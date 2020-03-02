#########
# Backend
#########
terraform {

  required_version = ">= 0.12.0"

  required_providers {
    restapi = ">= 1.11"
  }

  backend "local" {
    path = ".terraform/tf-state/terraform.tfstate"

  }
}

###########
# Providers
###########

provider "restapi" {
  uri                  = var.grf_url
  username             = var.grf_user
  password             = var.grf_password
  write_returns_object = true
}

#########
# Modules 
#########

module "terraform-restapi-grafana-datasources-cfg" {
  source      = "github.com/stefanponik/terraform-restapi-grafana-datasources-cfg.git?ref=v0.0.1"
  datasources = var.datasources
}
