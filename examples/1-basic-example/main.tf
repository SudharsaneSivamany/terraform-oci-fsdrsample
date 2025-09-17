provider "oci" {
  region              = "us-phoenix-1"
  auth                = "SecurityToken"
  config_file_profile = "DEFAULT"
}

module "dr_protection_group" {
  for_each       = { for entry in yamldecode(file("${path.module}/config.yaml"))["dr"] : entry.display_name => entry }
  source         = "../../modules/dr_protection_group"
  compartment_id = each.value["compartment_id"]
  defined_tags   = each.value["defined_tags"]
  display_name   = each.value["display_name"]
  log_location   = each.value["log_location"]
  members        = each.value["members"]
}

module "dr_plan_execution" {
  source = "../../modules/dr_plan_and_execution"
  dr_plan = merge(yamldecode(file("${path.module}/config.yaml"))["dr_plan"],{dr_protection_group_id = module.dr_protection_group["drpg-phx"].dr_protection_group["id"]})
}

