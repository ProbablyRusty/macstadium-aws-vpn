variable "needed_in_aws" {
  type = "string"

  description = <<EOF
  This value determines which AWS resources need to be created as part of this
  automated process. The three supported values are: 'create_vpc',
  'create_gateway', and 'just_vpn'.

  Set to 'create_vpc' if you want to create a new AWS VPC, AWS Virtual Private
  Gateway, AWS VPN, and (optionally) one or more t2.nano Amazon Linux test
  Instances inside of this new AWS VPC. This is the best option if you currently
  have no infrastructure in AWS, or if you want to demo or experiment with this
  automated process.

  Set to 'create_gateway' if you already have an existing AWS VPC, and you want
  to create an AWS Virtual Private Gateway and AWS VPN for this already-existing
  AWS VPC, for which you will supply the VPC ID and one or more already-existing
  Route Table IDs inside your VPC. (See the 'existing_vpc_id' and
  'vpc_route_table_ids' variables below.)

  Set to 'just vpn' if you already have an existing AWS VPC and AWS Virtual
  Private Gateway, and you simply want to create an AWS VPN for this
  already-existing AWS Virtual Private Gateway, for which you will supply the
  Virtual Private Gateway ID and VPC ID. (See the 'existing_vgw_id' and
  'existing_vpc_id' variables below.)
  EOF
}

variable "aws_vpc_cidr" {
  type = "string"

  description = <<EOF
  If you set the 'needed_in_aws' variable to 'create_gateway' or 'just_vpn',
  then this is is network for your existing AWS VPC. (This needs to be in CIDR
  notation, for example: 172.20.0.0/16.)

  Otherwise, if you set 'needed_in_aws' to 'create_vpc', then this is the
  desired network for your new AWS VPC that will be created. (Again, this needs
  to be in CIDR notation, for example: 172.20.0.0/16.))
  EOF
}

variable "existing_vpc_id" {
  type = "string"

  description = <<EOF
  If you set 'needed_in_aws' to 'create_gateway' or 'just_vpn', then you need to
  provide a VPC ID (for example: 'vpc-1234abcd') of an already-existing VPC
  (located in the AWS Region you specified).

  If you set 'needed_in_aws' to 'create_vpc', then you may set this to 'none',
  since a brand new VPC will be automatically created.
  EOF
}

variable "existing_vgw_id" {
  type = "string"

  description = <<EOF
  If you set 'needed_in_aws' to 'just_vpn', then you need to provide a Virtual
  Private Gateway ID (for example: 'vgw-1234abcd') of an already-existing
  Virtual Private Gateway (located in the AWS Region you specified).

  If you set 'needed_in_aws' to 'create_vpc' or 'create_gateway', then you may
  set this to 'none', since a brand new Virtual Private Gateway will be
  automatically created.
  EOF
}

variable "vpc_route_table_ids" {
  type = "string"

  description = <<EOF
  If you set 'needed_in_aws' to 'create_gateway', then you need to provide a
  comma-separated list of already-existing Route Table IDs (for example:
  'rtb-1234abcd,rtb-9876dcba') that reside in the VPC you specified in
  'existing_vpc_id'. You only need to include the IDs for Route Tables for that
  you want to include for routing traffic between AWS and MacStadium. If you
  only have one Route Table in the VPC (or choose to only include one Route
  Table here), then just specify the single Route Table ID without any commas.

  If you set 'needed_in_aws' to 'create_vpc', then you may set this to 'none',
  since a brand new Route Table will be automatically created in the brand new
  VPC which will also be automatically created.

  If you set 'needed_in_aws' to 'just_vpn', then you may also set this to
  'none', since only an AWS VPN will by created and simply attached to your
  already-existing Virtual Private Gateway. Further management of your Route
  Tables will be your repsonsibility in this scenario.
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
  AWS Access Key ID for a valid pair of API credentials for your AWS asccount
  (for example: 'AKIAI44QH8DHBEXAMPLE').
  EOF
}

variable "aws_secret_key" {
  type = "string"

  description = <<EOF
  AWS Secret Key for a valid pair of API credentials for your AWS asccount (for
  example: 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY').
  EOF
}

variable "macstadium_cidr" {
  type = "string"

  description = <<EOF
  Network for the Private-1 network of the MacStadium Private Cloud in CIDR
  notation, (for example: '10.254.20.0/24'), provided by MacStadium in your
  IP_PLAN document.
  EOF
}

variable "cisco_inside_1_ip_address" {
  type = "string"

  description = <<EOF
  IP address for the Cisco firewall's Inside-1 interface, provided by MacStadium
  in your IP_PLAN document.
  EOF
}

variable "cisco_wan_ip_address" {
  type = "string"

  description = <<EOF
  IP address for the Cisco firewall's WAN interface, provided by MacStadium in
  your IP_PLAN document.
  EOF
}

variable "cisco_firewall_username" {
  type = "string"

  description = <<EOF
  Username for the MacStadium Cisco firewall, provided by MacStadium in your
  IP_PLAN document.
  EOF
}

variable "cisco_firewall_password" {
  type = "string"

  description = <<EOF
  Password for the MacStadium Cisco firewall, provided by MacStadium in your
  IP_PLAN document.
  EOF
}

variable "macstadium_vcenter_management_username" {
  type = "string"

  description = <<EOF
  Username for MacStadium VCenter management, provided by MacStadium in your
  IP_PLAN document.
  EOF
}

variable "macstadium_vcenter_management_password" {
  type = "string"

  description = <<EOF
  Password for MacStadium VCenter management, provided by MacStadium in your
  IP_PLAN document.
  EOF
}

variable "macstadium_vcenter_management_ip_address" {
  type = "string"

  description = <<EOF
  IP address for MacStadium VCenter management, provided by MacStadium in your
  IP_PLAN document.
  EOF
}

variable "macstadium_vcenter_datacenter_name" {
  type = "string"

  description = <<EOF
  Name of your MacStadium VCenter datacenter, provided by MacStadium, (for
  example: 'MacStadium - VEGAS').
  EOF
}

variable "macstadium_vcenter_cluster_name" {
  type = "string"

  description = <<EOF
  Name of your MacStadium VCenter cluster, provided by MacStadium, (for example:
  'XSERVE_Cluster').
  EOF
}

variable "macstadium_vcenter_datastore_name" {
  type = "string"

  description = <<EOF
  Name of your MacStadium VCenter data store, provided by MacStadium, (for
  example: '1TB_SSD').
  EOF
}

variable "create_macstadium_test_instances" {
  type = "string"

  description = <<EOF
  Set to 'true' if you want to create test VMs in your MacStadium Private Cloud.
  Otherwise set to 'false'. Note that if you do set this to 'true', you will
  need an already-existing VM template in your Private Cloud from which to clone
  these test VMs.
  EOF
}

variable "macstadium_vcenter_vm_template_name" {
  type = "string"

  description = <<EOF
  Name of of a Virtual Machine Template, previously uploaded or created by you
  in VCenter, (for example: 'centos'). If you set 'create_macstadium_test_instances'
  to 'false', then you may set this to 'none'.
  EOF
}

variable "number_of_aws_test_instances" {
  type = "string"

  description = <<EOF
  If you set 'needed_in_aws' to 'create_vpc', then specify the number of Amazon
  Linux test instances you would like to automatically create inside this new
  VPC. Note that a brand new private SSH key to access the 'ec2-user' account on
  these Instances will be generated in this directory on your local machine.
  That key file will be named 'macstadium_aws_key'. Also note that if you do not
  want to create any Amazon Linux test instances in this scenario, you may set
  this value to 0.
  EOF
}

variable "number_of_macstadium_test_instances" {
  type = "string"

  description = <<EOF
  If you set 'create_macstadium_test_instances' to 'true', then specify the
  number of test VMs you would like to automatically create inside of your
  MacStadium Private Cloud. This VMs will need to be based on a Virtual Machine
  Template which you previously have uploaded or created by you in VCenter (see:
  'macstadium_vcenter_vm_template_name').
  EOF
}
