module "example" {
  source = "../"

  organization_name = "terraform-tom"
  variable_sets =  {
  "varset-1" = {
    projects = ["Project 1", "Project-AIT"]
    // name        = "varset-1"
    description = "This is a TF created varset."
    variables = {
      vault_cluster_address = {
        // key = "vault_cluster_address"
        value       = "https://vault.company.com"
        description = "Vault FQDN"
        sensitive   = false
        category    = "terraform"
        hcl         = false
      }
    }
  }
}