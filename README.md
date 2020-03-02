# terraform-restapi-grafana-datasources-cfg

Module provide programmatic and state aware way to manage grafana datastore configuration using restapi provider. 

RestAPI provider is 3th party for more info visit: https://github.com/Mastercard/terraform-provider-restapi

# Terraform Requirements 

    terraform {
    
      required_version = ">= 0.12.0"

      required_providers {
        restapi = ">= 1.11"
      }

      backend "local" {
        path = ".terraform/tf-state/terraform.tfstate"

      }
    }

# Terraform module main.tf root module

    provider "restapi" {
      uri                  = var.grf_url
      username             = var.grf_user
      password             = var.grf_password
      write_returns_object = true
    }

    module "terraform-restapi-grafana-datasources-cfg" {
      source      = "../../terraform-restapi-grafana-datasources-cfg"
      datasources = var.datasources
    }

# Terraform.tfvars
- alternative use xx.auto.tfvars if you want to load them without using CLI flags.  

Example Variables sample for configuration

    grf_url      = "http://localhost:3000"
    grf_user     = "admin"
    grf_password = "Password1"

    datasources = [
      {
        name      = "influxdb-internal",
        type      = "influxdb",
        url       = "http://influxdb-dev-local:8086",
        database  = "_internal",
        isDefault = false,
        jsonData = {
          httpMode     = "GET",
          timeInterval = "5s"
        },
      },
      {
        name      = "influxdb-metricstore",
        type      = "influxdb",
        url       = "http://influxdb-dev-local:8086",
        database  = "MetricStore",
        isDefault = true,
        jsonData = {
          httpMode     = "GET",
          timeInterval = "5s"
        },
      },
      {
        name      = "elk-dev",
        type      = "elasticsearch",
        url       = "http://localhost:9200",
        database  = "logstash*",
        isDefault = false,
        jsonData = {
          esVersion                  = 60,
          maxConcurrentShardRequests = "3",
          timeField                  = "@timestamp",
          timeInterval               = "60s"
        },
      },
    ]

# Gotchas 
When Adding attribute eg. "isDefault = false" all list elements have to have it.

# Future Work 
- Extend module with aditional attributes as needed.

## License

MIT / BSD

# Author Information
Created on March 2020 by Stefan Ponik