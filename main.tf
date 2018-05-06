module "aws_vpc_infrastructure" {
  source                   = "github.com/ProbablyRusty/macstadium-aws-vpn-master//aws_vpc_infrastructure"
  create_vpc               = "${var.needed_in_aws == "create_vpc" ? 1 : 0}"
  aws_region               = "${var.aws_region}"
  aws_access_key           = "${var.aws_access_key}"
  aws_secret_key           = "${var.aws_secret_key}"
  aws_vpc_cidr             = "${var.aws_vpc_cidr}"
  macstadium_cidr          = "${var.macstadium_cidr}"
  number_of_test_instances = "${var.number_of_aws_test_instances}"
}

module "macstadium_aws_vpn" {
  source                    = "github.com/ProbablyRusty/macstadium-aws-vpn-master//macstadium_aws_vpn"
  need_vpg                  = "${(var.needed_in_aws == "create_vpc") || (var.needed_in_aws == "create_gateway") ? "true" : "false"}"
  aws_region                = "${var.aws_region}"
  aws_access_key            = "${var.aws_access_key}"
  aws_secret_key            = "${var.aws_secret_key}"
  macstadium_cidr           = "${var.macstadium_cidr}"
  aws_vpc_cidr              = "${var.aws_vpc_cidr}"
  cisco_wan_ip_address      = "${var.cisco_wan_ip_address}"
  cisco_inside_1_ip_address = "${var.cisco_inside_1_ip_address}"
  cisco_firewall_username   = "${var.cisco_firewall_username}"
  cisco_firewall_password   = "${var.cisco_firewall_password}"
  aws_vpc_id                = "${var.needed_in_aws == "create_vpc" ? (length(module.aws_vpc_infrastructure.aws_vpc_id) > 0 ? element(concat(module.aws_vpc_infrastructure.aws_vpc_id, list("")), 0) : "") : var.existing_vpc_id}"
  existing_vgw_id           = "${var.existing_vgw_id}"
  aws_vpc_route_table_ids   = "${var.needed_in_aws == "create_vpc" ? (length(module.aws_vpc_infrastructure.aws_vpc_route_table_id) > 0 ? element(concat(module.aws_vpc_infrastructure.aws_vpc_route_table_id, list("")), 0) : "") : var.vpc_route_table_ids}"
  count_of_route_tables     = "${var.needed_in_aws == "create_vpc" ? "1" : length(split(",", var.vpc_route_table_ids))}"
}

module "macstadium_vsphere" {
  source                                   = "github.com/ProbablyRusty/macstadium-aws-vpn-master//macstadium_vsphere"
  create_macstadium_test_instances         = "${var.create_macstadium_test_instances == "true" ? 1 : 0}"
  macstadium_vcenter_management_username   = "${var.macstadium_vcenter_management_username}"
  macstadium_vcenter_management_password   = "${var.macstadium_vcenter_management_password}"
  macstadium_vcenter_management_ip_address = "${var.macstadium_vcenter_management_ip_address}"
  macstadium_vcenter_datacenter_name       = "${var.macstadium_vcenter_datacenter_name}"
  macstadium_vcenter_cluster_name          = "${var.macstadium_vcenter_cluster_name}"
  macstadium_vcenter_datastore_name        = "${var.macstadium_vcenter_datastore_name}"
  macstadium_vcenter_vm_template_name      = "${var.macstadium_vcenter_vm_template_name}"
  macstadium_cidr                          = "${var.macstadium_cidr}"
  number_of_test_instances                 = "${var.number_of_macstadium_test_instances}"
}
