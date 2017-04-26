# Set to 'true' if you want to create a new AWS VPC, and (optionally) one or more t2.nano Amazon Linux test
# Instances inside of this new AWS VPC. Otherwise set to 'false'.
create_vpc = "true"

# Network for your existing AWS VPC, if you set 'create_vpc' to 'false', or desired network for your new VPC
# that will be created, if you set 'create_vpc' to 'true'. (This needs to be in CIDR notation, for example:
# 172.20.0.0/16.)
aws_vpc_cidr = "CUSTOMIZE_THIS"

# If you set 'create_vpc' to 'false', then you need to provide a VPC ID (for example: 'vpc-1234abcd') of an
# already-existing VPC (located in the AWS Region you specified). If you set 'create_vpc' to 'true', then you
# may set this to 'none', since a brand new VPC will be automatically created.
existing_vpc_id = "CUSTOMIZE_THIS"

# If you set 'create_vpc' to 'false', then you need to provide a comma-separated list of already-existing
# Route Table IDs (for example: 'rtb-1234abcd,rtb-9876dcba') that reside in the VPC you specified in
# 'existing_vpc_id'. You only need to include the IDs for Route Tables for that you want to include for
# routing traffic between AWS and MacStadium. If you only have one Route Table in the VPC (or choose to only
# include one Route Table here), then just specify the single Route Table ID without any commas. If you set
# 'create_vpc' to 'true', then you may set this to 'none', since a brand new Route Table will be automatically
# created in the brand new VPC which will also be automatically created.
vpc_route_table_ids = "CUSTOMIZE_THIS"

# AWS Region where your VPC is (or will be) located (for example, 'us-east-1').
aws_region = "us-east-1"

# AWS Access Key ID for a valid pair of API credentials for your AWS asccount (for example:
# 'AKIAI44QH8DHBEXAMPLE').
aws_access_key = "CUSTOMIZE_THIS"

# AWS Secret Key for a valid pair of API credentials for your AWS asccount (for example:
# 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY').
aws_secret_key = "CUSTOMIZE_THIS"

# Network for the Private-1 network of the MacStadium Private Cloud in CIDR notation, (for example:
# '10.254.20.0/24'), provided by MacStadium in your IP_PLAN document.
macstadium_cidr = "CUSTOMIZE_THIS"

# IP address for the Cisco firewall's Inside-1 interface, provided by MacStadium in your IP_PLAN document.
cisco_inside_1_ip_address = "CUSTOMIZE_THIS"

# IP address for the Cisco firewall's WAN interface, provided by MacStadium in your IP_PLAN document.
cisco_wan_ip_address = "CUSTOMIZE_THIS"

# Username for the MacStadium Cisco firewall, provided by MacStadium in your IP_PLAN document.
cisco_firewall_username = "CUSTOMIZE_THIS"

# Passsword for the MacStadium Cisco firewall, provided by MacStadium in your IP_PLAN document.
cisco_firewall_password = "CUSTOMIZE_THIS"

# Username for MacStadium VCenter management, provided by MacStadium in your IP_PLAN document.
macstadium_vcenter_management_username = "CUSTOMIZE_THIS"

# Password for MacStadium VCenter management, provided by MacStadium in your IP_PLAN document.
macstadium_vcenter_management_password = "CUSTOMIZE_THIS"

# IP address for MacStadium VCenter management, provided by MacStadium in your IP_PLAN document.
macstadium_vcenter_management_ip_address = "CUSTOMIZE_THIS"

# Name of your MacStadium VCenter datacenter, provided by MacStadium, (for example: 'MacStadium - VEGAS').
macstadium_vcenter_datacenter_name = "MacStadium - VEGAS"

# Name of your MacStadium VCenter cluster, provided by MacStadium, (for example: 'XSERVE_Cluster').
macstadium_vcenter_cluster_name = "XSERVE_Cluster"

# Name of your MacStadium VCenter data store, provided by MacStadium, (for example: '1TB_SSD').
macstadium_vcenter_datastore_name = "1TB_SSD"

# Set to 'true' if you want to create test VMs in your MacStadium Private Cloud. Otherwise set to 'false'.
# Note that if you do set this to 'true', you will need a VM template in your Private Cloud from which to
# clone these test VMs.
create_macstadium_test_instances = "false"

# Name of of a Virtual Machine Template, previously uploaded or created by you in VCenter, (for example:
# 'centos'). If you set 'create_macstadium_test_instances' to 'false', then you may set this to 'none'.
macstadium_vcenter_vm_template_name = "CUSTOMIZE_THIS"

# If you set 'create_vpc' to 'true', then specify the number of Amazon Linux test instances you would like to
# automatically create inside this new VPC. Note that a brand new private SSH key to access the 'ec2-user'
# account on these Instances will be generated in this directory on your local machine. That key file will be
# named 'macstadium_aws_key'.
number_of_aws_test_instances = "2"

# If you set 'create_macstadium_test_instances' to 'true', then specify the number of test VMs you would like
# to automatically create inside of your MacStadium Private Cloud. This VMs will need to be based on a Virtual
# Machine Template which you previously have uploaded or created by you in VCenter (see:
# 'macstadium_vcenter_vm_template_name').
number_of_macstadium_test_instances = "2"
