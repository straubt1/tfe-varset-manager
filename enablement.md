# Enablement

Often we see Terraform code in the wild like this:

```
something_complex = { for e in flatten([
  for v in var.variableA : [
    for p in v.variableP : {
      key           = format("%s_%s", v.name, p)
      resource_name = p
      id            = v.id
    }
  ]
]) : e.key => e }
```

<details>
  <summary>What???</summary>

  ![](https://media2.giphy.com/media/3o85xFGjUBlUw4XEek/giphy.gif?cid=6104955eypq7ictaa0547uxkj02urr5pvw9ftd1zns2egy1h&ep=v1_gifs_translate&rid=giphy.gif&ct=g)
</details>



## Problem Set

Input a list of Variable Sets (`varset`) where each contains a list of Variables (`var`) and Project Assigments by name (`projectname`).

The Projects already exist in this example.

Visualization of the desired outcome of the Terraform:

![](./images/Desired%20State.png)


## Approach

1. Define Terraform Resources/Data Sources that will be needed.
2. Define the input variables, structure, and relationships.
3. Create a `locals` block with the data manipulations needed.
4. Test with a "debug" `output` block.
5. Wire up Resources/Data Sources.
6. Success!

## Define Terraform Resources

![](./images/Desired%20Resources.png)


```
data "tfe_project" "foo" {
  name = "my-project-name"
  organization = "my-org-name"
}
```
[source](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/project)


```
resource "tfe_variable_set" "test" {
  name          = "Test Varset"
  description   = "Some description."
  organization  = tfe_organization.test.name
}
```
[source](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set)


```
resource "tfe_variable" "test-a" {
  key             = "separate_variable"
  value           = "my_value_name"
  category        = "terraform"
  description     = "a useful description"
  variable_set_id = tfe_variable_set.test.id
}
```
[source](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)


```
resource "tfe_project_variable_set" "test" {
  variable_set_id = tfe_variable_set.test.id
  project_id      = tfe_project.test.id
}
```
[source](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project_variable_set)


## Define Terraform Variables

### Input

* List of all Variable Sets
* List of Projects that Variable Set is to be assigned to
* List of Variables to be created in each Variable Set


### Locals

Going to need:
* List of all contained Project Id's (but given their names) -> Data Source
* List of all Variable Set Names -> Resource
* List of all Variables organized by Variable Set Id's -> Resource
* List of all Variable Set Assignments by Id and associated Project Id
