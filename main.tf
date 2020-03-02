########
# Locals
########

locals {
  datasource_counter = length(var.datasources)
  datasource_defaults = {
    access = "proxy",
  }
}

###########
# Resources
###########

resource "restapi_object" "api-elk-dev" {
  count = local.datasource_counter
  path  = "/api/datasources"
  data  = jsonencode(merge(var.datasources[count.index], local.datasource_defaults))
}
