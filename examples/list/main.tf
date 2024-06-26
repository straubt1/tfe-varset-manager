module "list" {
  source = "../../modules/list"

  organization_name = "terraform-tom"
  variable_sets = [
    {
      name        = "varset-1"
      description = "This is a Terraform managed varset."
      projects    = ["Project A", "Project B"]
      variables = [
        {
          key         = "vault1_cluster_address"
          value       = "https://vault1.company.com"
          description = "Vault1 FQDN"
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
      description = "This is a Terraform managed varset."
      projects    = ["Project B"]
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
    },
    {
      name        = "varset-3"
      description = "This is a Terraform managed varset."
      projects    = ["Project B", "Project C"]
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
}

output "module_output" {
  value = module.list
}
