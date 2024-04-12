locals { # locals to do all the variable coordination
  # List of all referenced Project Names
  tfe_projects = ["Project A", "Project B", "Project C"]

  # Map of all Variable Sets to create
  tfe_variable_sets = {
    varset-1 = {
      description = "This is a Terraform managed varset."
      name        = "varset-1"
    }
    varset-2 = {
      description = "This is a Terraform managed varset."
      name        = "varset-2"
    }
    varset-3 = {
      description = "This is a Terraform managed varset."
      name        = "varset-3"
    }
  }

  # Map of all Variables to create for all Variable Sets
  tfe_variables = {
    varset-1_vault1_cluster_address = {
      category    = "terraform"
      description = "Vault1 FQDN"
      hcl         = false
      key         = "varset-1_vault1_cluster_address"
      name        = "vault1_cluster_address"
      sensitive   = false
      value       = "https://vault1.company.com"
      varset_key  = "varset-1"
    }
    varset-1_vault2_cluster_address = {
      category    = "terraform"
      description = "Vault2 FQDN"
      hcl         = false
      key         = "varset-1_vault2_cluster_address"
      name        = "vault2_cluster_address"
      sensitive   = false
      value       = "https://vault2.company.com"
      varset_key  = "varset-1"
    }
    varset-1_vault3_cluster_address = {
      category    = "terraform"
      description = "Vault3 FQDN"
      hcl         = false
      key         = "varset-1_vault3_cluster_address"
      name        = "vault3_cluster_address"
      sensitive   = false
      value       = "https://vault3.company.com"
      varset_key  = "varset-1"
    }
    varset-2_vault3_cluster_address = {
      category    = "terraform"
      description = "Vault3 FQDN"
      hcl         = false
      key         = "varset-2_vault3_cluster_address"
      name        = "vault3_cluster_address"
      sensitive   = false
      value       = "https://vault3.company.com"
      varset_key  = "varset-2"
    }
    varset-2_vault_cluster_address = {
      category    = "terraform"
      description = "Vault FQDN"
      hcl         = false
      key         = "varset-2_vault_cluster_address"
      name        = "vault_cluster_address"
      sensitive   = false
      value       = "https://vault.company.com"
      varset_key  = "varset-2"
    }
    varset-3_vault3_cluster_address = {
      category    = "terraform"
      description = "Vault3 FQDN"
      hcl         = false
      key         = "varset-3_vault3_cluster_address"
      name        = "vault3_cluster_address"
      sensitive   = false
      value       = "https://vault3.company.com"
      varset_key  = "varset-3"
    }
    varset-3_vault_cluster_address = {
      category    = "terraform"
      description = "Vault FQDN"
      hcl         = false
      key         = "varset-3_vault_cluster_address"
      name        = "vault_cluster_address"
      sensitive   = false
      value       = "https://vault.company.com"
      varset_key  = "varset-3"
    }
  }

  # Map of all Variable Set assignments to Projects
  tfe_varset_assignment = {
    "varset-1_Project A" = {
      key          = "varset-1_Project A"
      project_name = "Project A"
      varset_name  = "varset-1"
    }
    "varset-1_Project B" = {
      key          = "varset-1_Project B"
      project_name = "Project B"
      varset_name  = "varset-1"
    }
    "varset-2_Project B" = {
      key          = "varset-2_Project B"
      project_name = "Project B"
      varset_name  = "varset-2"
    }
    "varset-3_Project B" = {
      key          = "varset-3_Project B"
      project_name = "Project B"
      varset_name  = "varset-3"
    }
    "varset-3_Project C" = {
      key          = "varset-3_Project C"
      project_name = "Project C"
      varset_name  = "varset-3"
    }
  }
}

output "debug" {
  value = {
    tfe_projects = local.tfe_projects
    # tfe_variable_sets = local.tfe_variable_sets
    # tfe_variables = local.tfe_variables
    # tfe_varset_assignment = local.tfe_varset_assignment
  }
}

# # Lookup existing Project Id's based on passed in Project Names
# data "tfe_project" "main" {
#   for_each = local.tfe_projects

#   name         = each.key
#   organization = var.organization_name
# }

# resource "tfe_variable_set" "main" {
#   for_each = local.tfe_variable_sets

#   organization = var.organization_name

#   name        = each.key
#   description = each.value.description
# }

# resource "tfe_variable" "main" {
#   for_each = local.tfe_variables

#   key             = each.value.name
#   value           = each.value.value
#   category        = each.value.category
#   description     = each.value.description
#   variable_set_id = tfe_variable_set.main[each.value.varset_key].id
# }

# resource "tfe_project_variable_set" "main" {
#   for_each = local.tfe_varset_assignment

#   variable_set_id = tfe_variable_set.main[each.value.varset_name].id
#   project_id      = data.tfe_project.main[each.value.project_name].id
# }

