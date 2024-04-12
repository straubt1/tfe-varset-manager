locals {
  list = ["elementA", "elementB", "elementC"]
  v_as_map = { for l in local.list : l => {
    lower  = lower(l)
    upper  = upper(l)
    random = strrev(l)
    split  = split("", l)
  } }
  v_as_list = [for l in local.list : l]
}

output "debug" {
  value = {
    v_as_map  = local.v_as_map
    v_as_list = local.v_as_list
  }
}
