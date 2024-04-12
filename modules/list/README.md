# README

## Locals


```
tfe_projects = toset(distinct(flatten([
  for varset in var.variable_sets : [
    varset.projects
  ]
])))

tfe_variable_sets = {
  for varset in var.variable_sets : varset.name => {
    name        = varset.name
    description = varset.description
  }
}

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

tfe_varset_assignment = { for e in flatten([
  for varset in var.variable_sets : [
    for p in varset.projects : {
      key = format("%s_%s", varset.name, p)

      project_name = p
      varset_name  = varset.name
    }
  ]
]) : e.key => e }
```