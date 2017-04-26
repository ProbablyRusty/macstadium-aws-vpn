variable "create_vpc" {
  type = "string"

  description = <<EOF
  Set to 'true' if you want to create a new AWS VPC, and (optionally) one or more t2.nano Amazon Linux test
  Instances inside of this new AWS VPC. Otherwise set to 'false'.
  EOF
}

variable "aws_vpc_cidr" {
  type = "string"

  description = <<EOF
  Network for your existing AWS VPC, if you set 'create_vpc' to 'false', or desired network for your new VPC
  that will be created, if you set 'create_vpc' to 'true'. (This needs to be in CIDR notation, for example:
  172.20.0.0/16.)
  EOF
}

variable "existing_vpc_id" {
  type = "string"

  description = <<EOF
  If you set 'create_vpc' to 'false', then you need to provide a VPC ID (for example: 'vpc-1234abcd') of an
  already-existing VPC (located in the AWS Region you specified). If you set 'create_vpc' to 'true', then you
  may set this to 'none', since a brand new VPC will be automatically created.
  EOF
}

variable "vpc_route_table_ids" {
  type = "string"

  description = <<EOF
  If you set 'create_vpc' to 'false', then you need to provide a comma-separated list of already-existing
  Route Table IDs (for example: 'rtb-1234abcd,rtb-9876dcba') that reside in the VPC you specified in
  'existing_vpc_id'. You only need to include the IDs for Route Tables for that you want to include for
  routing traffic between AWS and MacStadium. If you only have one Route Table in the VPC (or choose to only
  include one Route Table here), then just specify the single Route Table ID without any commas. If you set
  'create_vpc' to 'true', then you may set this to 'none', since a brand new Route Table will be automatically
  created in the brand new VPC which will also be automatically created.
  EOF
}

variable "aws_region" {
  type = "string"

  description = <<EOF
  AWS Region where your VPC is (or will be) located (for example, 'us-east-1').
  EOF
}

variable "aws_access_key" {
  type = "string"

  description = <<EOF
  AWS Access Key ID for a valid pair of API credentials for your AWS asccount (for example:
  'AKIAI44QH8DHBEXAMPLE').
  EOF
}

variable "aws_secret_key" {
  type = "string"

  description = <<EOF
  AWS Secret Key for a valid pair of API credentials for your AWS asccount (for example:
  'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY').
  EOF
}

variable "macstadium_cidr" {
  type = "string"

  description = <<EOF
  Network for the Private-1 network of the MacStadium Private Cloud in CIDR notation, (for example:
  '10.254.20.0/24'), provided by MacStadium in your IP_PLAN document.
  EOF
}

variable "cisco_inside_1_ip_address" {
  type = "string"

  description = <<EOF
  IP address for the Cisco firewall's Inside-1 interface, provided by MacStadium in your IP_PLAN document.
  EOF
}

variable "cisco_wan_ip_address" {
  type = "string"

  description = <<EOF
  IP address for the Cisco firewall's WAN interface, provided by MacStadium in your IP_PLAN document.
  EOF
}

variable "cisco_firewall_username" {
  type = "string"

  description = <<EOF
  Username for the MacStadium Cisco firewall, provided by MacStadium in your IP_PLAN document.
  EOF
}

variable "cisco_firewall_password" {
  type = "string"

  description = <<EOF
  Passsword for the MacStadium Cisco firewall, provided by MacStadium in your IP_PLAN document.
  EOF
}

variable "macstadium_vcenter_management_username" {
  type = "string"

  description = <<EOF
  Username for MacStadium VCenter management, provided by MacStadium in your IP_PLAN document.
  EOF
}

variable "macstadium_vcenter_management_password" {
  type = "string"

  description = <<EOF
  Password for MacStadium VCenter management, provided by MacStadium in your IP_PLAN document.
  EOF
}

variable "macstadium_vcenter_management_ip_address" {
  type = "string"

  description = <<EOF
  IP address for MacStadium VCenter management, provided by MacStadium in your IP_PLAN document.
  EOF
}

variable "macstadium_vcenter_datacenter_name" {
  type = "string"

  description = <<EOF
  Name of your MacStadium VCenter datacenter, provided by MacStadium, (for example: 'MacStadium - VEGAS').
  EOF
}

variable "macstadium_vcenter_cluster_name" {
  type = "string"

  description = <<EOF
  Name of your MacStadium VCenter cluster, provided by MacStadium, (for example: 'XSERVE_Cluster').
  EOF
}

variable "macstadium_vcenter_datastore_name" {
  type = "string"

  description = <<EOF
  Name of your MacStadium VCenter data store, provided by MacStadium, (for example: '1TB_SSD').
  EOF
}

variable "create_macstadium_test_instances" {
  type = "string"

  description = <<EOF
  Set to 'true' if you want to create test VMs in your MacStadium Private Cloud. Otherwise set to 'false'.
  Note that if you do set this to 'true', you will need a VM template in your Private Cloud from which to
  clone these test VMs.
  EOF
}

variable "macstadium_vcenter_vm_template_name" {
  type = "string"

  description = <<EOF
  Name of of a Virtual Machine Template, previously uploaded or created by you in VCenter, (for example:
  'centos'). If you set 'create_macstadium_test_instances' to 'false', then you may set this to 'none'.
  EOF
}

variable "number_of_aws_test_instances" {
  type = "string"

  description = <<EOF
  If you set 'create_vpc' to 'true', then specify the number of Amazon Linux test instances you would like to
  automatically create inside this new VPC. Note that a brand new private SSH key to access the 'ec2-user'
  account on these Instances will be generated in this directory on your local machine. That key file will be
  named 'macstadium_aws_key'.
  EOF
}

variable "number_of_macstadium_test_instances" {
  type = "string"

  description = <<EOF
  If you set 'create_macstadium_test_instances' to 'true', then specify the number of test VMs you would like
  to automatically create inside of your MacStadium Private Cloud. This VMs will need to be based on a Virtual
  Machine Template which you previously have uploaded or created by you in VCenter (see:
  'macstadium_vcenter_vm_template_name').
  EOF
}
