# tfe-varset-manager

## Example

`terraform.tfvars` file:

```
organization_name = "terraform-tom"
variable_sets = [
  {
    name        = "varset-1"
    description = "This is a TF created varset."
    projects    = ["Project 1"]
    variables = [
      {
        key         = "vault_cluster_address"
        value       = "https://vault.company.com"
        description = "Vault FQDN"
        sensitive   = false
        category    = "terraform"
        hcl         = false
      },
      {
        key         = "vault2_cluster_address"
        value       = "https://vault2.company.com"
        description = "Vault2 FQDN"
        sensitive   = false
        category    = "terraform"
        hcl         = false
      },
      {
        key         = "vault3_cluster_address"
        value       = "https://vault3.company.com"
        description = "Vault3 FQDN"
        sensitive   = false
        category    = "terraform"
        hcl         = false
      }
    ]
  },
  {
    name        = "varset-2"
    description = "This is a TF created varset."
    projects    = ["Project 1", "Project-AIT"]
    variables = [
      {
        key         = "vault_cluster_address"
        value       = "https://vault.company.com"
        description = "Vault FQDN"
        sensitive   = false
        category    = "terraform"
        hcl         = false
      },
      {
        key         = "vault3_cluster_address"
        value       = "https://vault3.company.com"
        description = "Vault3 FQDN"
        sensitive   = false
        category    = "terraform"
        hcl         = false
      }
    ]
  }
]
```

`terraform plan` results:

```sh
terraform plan
data.tfe_project.main["Project 1"]: Reading...
data.tfe_project.main["Project-AIT"]: Reading...
data.tfe_project.main["Project 1"]: Read complete after 0s [id=prj-X2MDPdvsLzHzh9YG]
data.tfe_project.main["Project-AIT"]: Read complete after 0s [id=prj-PoZMjLruXSXw45eV]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # tfe_project_variable_set.main["varset-1_Project 1"] will be created
  + resource "tfe_project_variable_set" "main" {
      + id              = (known after apply)
      + project_id      = "prj-X2MDPdvsLzHzh9YG"
      + variable_set_id = (known after apply)
    }

  # tfe_project_variable_set.main["varset-2_Project 1"] will be created
  + resource "tfe_project_variable_set" "main" {
      + id              = (known after apply)
      + project_id      = "prj-X2MDPdvsLzHzh9YG"
      + variable_set_id = (known after apply)
    }

  # tfe_project_variable_set.main["varset-2_Project-AIT"] will be created
  + resource "tfe_project_variable_set" "main" {
      + id              = (known after apply)
      + project_id      = "prj-PoZMjLruXSXw45eV"
      + variable_set_id = (known after apply)
    }

  # tfe_variable.main["varset-1_vault2_cluster_address"] will be created
  + resource "tfe_variable" "main" {
      + category        = "terraform"
      + description     = "Vault2 FQDN"
      + hcl             = false
      + id              = (known after apply)
      + key             = "vault2_cluster_address"
      + readable_value  = "https://vault2.company.com"
      + sensitive       = false
      + value           = (sensitive value)
      + variable_set_id = (known after apply)
    }

  # tfe_variable.main["varset-1_vault3_cluster_address"] will be created
  + resource "tfe_variable" "main" {
      + category        = "terraform"
      + description     = "Vault3 FQDN"
      + hcl             = false
      + id              = (known after apply)
      + key             = "vault3_cluster_address"
      + readable_value  = "https://vault3.company.com"
      + sensitive       = false
      + value           = (sensitive value)
      + variable_set_id = (known after apply)
    }

  # tfe_variable.main["varset-1_vault_cluster_address"] will be created
  + resource "tfe_variable" "main" {
      + category        = "terraform"
      + description     = "Vault FQDN"
      + hcl             = false
      + id              = (known after apply)
      + key             = "vault_cluster_address"
      + readable_value  = "https://vault.company.com"
      + sensitive       = false
      + value           = (sensitive value)
      + variable_set_id = (known after apply)
    }

  # tfe_variable.main["varset-2_vault3_cluster_address"] will be created
  + resource "tfe_variable" "main" {
      + category        = "terraform"
      + description     = "Vault3 FQDN"
      + hcl             = false
      + id              = (known after apply)
      + key             = "vault3_cluster_address"
      + readable_value  = "https://vault3.company.com"
      + sensitive       = false
      + value           = (sensitive value)
      + variable_set_id = (known after apply)
    }

  # tfe_variable.main["varset-2_vault_cluster_address"] will be created
  + resource "tfe_variable" "main" {
      + category        = "terraform"
      + description     = "Vault FQDN"
      + hcl             = false
      + id              = (known after apply)
      + key             = "vault_cluster_address"
      + readable_value  = "https://vault.company.com"
      + sensitive       = false
      + value           = (sensitive value)
      + variable_set_id = (known after apply)
    }

  # tfe_variable_set.main["varset-1"] will be created
  + resource "tfe_variable_set" "main" {
      + description   = "This is a TF created varset."
      + global        = false
      + id            = (known after apply)
      + name          = "varset-1"
      + organization  = "terraform-tom"
      + workspace_ids = (known after apply)
    }

  # tfe_variable_set.main["varset-2"] will be created
  + resource "tfe_variable_set" "main" {
      + description   = "This is a TF created varset."
      + global        = false
      + id            = (known after apply)
      + name          = "varset-2"
      + organization  = "terraform-tom"
      + workspace_ids = (known after apply)
    }

Plan: 10 to add, 0 to change, 0 to destroy.
```