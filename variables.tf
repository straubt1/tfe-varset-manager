variable "organization_name" {
  default = "terraform-tom"
}

variable "variable_sets" {
  description = "Map of all Variable Sets we will need to create"
  type = list(object({
    projects    = list(string)
    name        = string
    description = string
    variables = list(object(
      {
        key         = string
        value       = string
        description = string
        category    = string
        sensitive   = bool
        hcl         = bool
      }
    )) }
  ))
}
