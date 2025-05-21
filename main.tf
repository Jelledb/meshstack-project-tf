variable "project_definitions" {
  description = "List of projects with name and display name"
  type = list(object({
    name         = string
    display_name = string
  }))
}

provider "meshstack" {}

resource "meshstack_project" "projects" {
  for_each = { for project in var.project_definitions : project.name => project }

  metadata = {
    name               = each.value.name
    owned_by_workspace = "jelles-workspace"
  }

  spec = {
    payment_method_identifier = "jelle-unlimited-money"
    display_name              = each.value.display_name

    tags = {
      "Confidentiality" = [
        "Public"
      ]
    }
  }
}