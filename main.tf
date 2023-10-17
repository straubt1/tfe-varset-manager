
locals {

  # map of items of all referenced Projects
  tfe_projects = toset(distinct(flatten([
    for varset in var.variable_sets : [
      varset.projects
    ]
  ])))

  tfe_varset_assignment = { for e in flatten([
    for varset in var.variable_sets : [
      for p in varset.projects : {
        key = format("%s_%s", varset.name, p)

        project_name = p
        varset_name  = varset.name
      }
    ]
  ]) : e.key => e }
  # tfe_projects = { for p in distinct(flatten([
  #   for varset in var.variable_sets : [
  #     varset.projects
  #   ]
  # ])) : p => p }


  # map of items to create all variable sets
  tfe_variable_sets = {
    for varset in var.variable_sets : varset.name => {
      name        = varset.name
      description = varset.description
    }
  }

  # map of items to create all variables for all variable sets
  tfe_variables = { for e in flatten([
    for varset in var.variable_sets : [
      for v in varset.variables : {
        key        = format("%s_%s", varset.name, v.key)
        varset_key = varset.name

        name        = v.key
        value       = v.value
        description = v.description
        category    = v.category
        sensitive   = v.sensitive
        hcl         = v.hcl
      }
    ]
  ]) : e.key => e }
}

data "tfe_project" "main" {
  for_each = local.tfe_projects

  name         = each.key
  organization = var.organization_name
}


output "debug" {
  value = {
    a = local.tfe_varset_assignment
    # b = data.tfe_project.main
  }
}

resource "tfe_variable_set" "main" {
  for_each = local.tfe_variable_sets

  organization = var.organization_name

  name        = each.key
  description = each.value.description
}

resource "tfe_variable" "main" {
  for_each = local.tfe_variables

  key             = each.value.name
  value           = each.value.value
  category        = each.value.category
  description     = each.value.description
  variable_set_id = tfe_variable_set.main[each.value.varset_key].id
}

resource "tfe_project_variable_set" "main" {
  for_each = local.tfe_varset_assignment

  variable_set_id = tfe_variable_set.main[each.value.varset_name].id
  project_id      = data.tfe_project.main[each.value.project_name].id
}


