MacStadium AWS VPN
==================

MacStadium AWS VPN is a project which, using HashiCorp's [Terraform](https://www.terraform.io), automates the setup of a persistent [VPN tunnel](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_VPN.html) between a [MacStadium Hosted Mac Private Cloud](https://www.macstadium.com/cloud/) and an [AWS VPC](https://aws.amazon.com/vpc/).

Essentially, this project can be used with Terraform to automatically perform all of the following in a single process:

- (Optionally) create a basic AWS VPC with an Internet Gateway and single subnet.
- (Optionally) create a Virtual Private Gateway and attach it to the VPC
- Create an AWS IPSec VPN suitable for persistent tunneling between MacStadium and AWS
- Configure a MacStadium Cisco firewall (part of the Hosted Mac Private Cloud offering) to use this AWS VPN
- (Optionally) create one or more test EC2 instances in the AWS VPC
- (Optionally) create one or more test VMs in the MacStadium Hosted Mac Private Cloud

Three use cases are supported:

1. **Build Everything**: "I want to start from scratch in AWS. Have the automation create a VPC for me and all the related accoutrements. Then build the AWS VPN and configure my MacStadium Cisco firewall to use it."

1. **VPC Already Exists**: "I already have a VPC. Please just have the automation create a Virtual Private Gateway and the VPN in AWS. I'll supply ID for my VPC snd the ID(s) for one or more existing route tables in my VPC that I want to route to and from MacStadium."

1. **Gateway Aleady Exists**: "I already have a VPC and I also already have a Virtual Private Gateway created and attached to it. I want the automation to _only_ create the VPN between AWS and MacStadium. I'll supply the ID of the existing AWS Virtual Private Gateway that is already in use for my VPC."

The general process of deploying this automation is not only simple and straightforward, it is exactly the same for all three use cases:

1. [Customize some variables](#step-1-customize-variables)

1. [Run `terraform apply`](#step-2-run-terraform)

1. [Profit](#step-3-profit)


Before You Begin
----------------

First some prerequisites:

- Ideally, [Git should be installed](https://gist.github.com/derhuerst/1b15ff4652a867391f03), if it is not already.

- You should have a local copy of this repo on your own computer. One very easy way to obtain it is simply to clone it from GitHub:

	```bash
	git clone https://github.com/consultantRR/macstadium-aws-vpn.git
	```

- You'll definitely need to have [Terraform](https://www.terraform.io) installed. One easy way to do that on a Mac would be to use [Homebrew](https://brew.sh) as follows:


	```bash
	brew install terraform
	```
- [AWS API Credentials](http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) with sufficient privileges for creating VPC and EC2 resources for the AWS account you will be working with will be needed.

- Several credentials and technical details about your MacStadium Hosted Mac Private Cloud will be needed as well. Typically, all of this information is supplied by MacStadium in a custom spreadsheet document titled `YourName_IP_PLAN.xlsx`, or something similar.  Contact MacStadium with questions.

- When you run `terraform apply` in [Step 2 (below)](#step-2-run-terraform), your computer will need to be connected to the per-user IPSec VPN your MacStadium Cisco firewall, which is enabled by default as part of your Hosted Mac Private Cloud. MacStadium has posted [setup instructions](http://www.macstadium.com/blog/how-to-setup-a-cisco-vpn-connection-in-mac-os-x-and-windows/) on how to accomplish that. Again, make sure you are connected to this VPN from your computer prior to proceeding with [Step 2 (below)](#step-2-run-terraform).

Step 1: Customize Variables
-------------------

This project includes a [variables template file](my-variables.hcl) which you will need to customize for your specific use case, credentials, and specifications before applying the automation.

Each variable in the [my-variables.hcl](my-variables.hcl) file is documented in-line within that file. For convenience and easy reference, each of those variables (and its explanatory comment) is additionally included in an [Appendix](#appendix-reference-list-of-variables) at the end of this ReadMe.

But generally, you will simply need to edit each variable with appropriate values in this file prior to proceeding.

Note that the `needed_in_aws` variable corresponds to the three supported use cases summarized at the beginning of this ReadMe, and should be set accordingly to your particular use case. Here are some specifics on what that means:

| Which <br/> Use Case? | Value To Use For <br/> [`needed_in_aws`](#variable-needed_in_aws) | Creates <br/> VPC | Creates <br/> Gateway | Creates <br/> VPN | AWS <br/> Test Instances | MacStadium <br/> Test VMs |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Build Everything | `create_vpc` | Yes | Yes | Yes | Optional | Optional |
| VPC Already Exists | `create_gateway` | No | Yes | Yes | No | Optional |
| Gateway Aleady Exists | `just_vpn` | No | No | Yes | No | Optional |

Step 2: Run Terraform
---------------------

Okay, so now that you have taken care of perquisites and also set custom values for all appropriate variables, you can now proceed.

First, `cd` into the directory of this project, if you haven't already:

```bash
cd macstadium-aws-vpn
```

Next, ask Terraform to fetch any modules which are referenced in this project:

```bash
terraform get
```

Now, although technically this is not a necessary step, it is good practice to try `terraform plan` prior to actually building or configuring anything. This command will evaluate the process and let you know what Terraform _would_ do if you ran `terraform apply`, but it will not actually perform any of those actions at this stage. Specifically, using your custom variables, you would do this:

```bash
terraform plan -var-file=my-variables.hcl
```

Errors after this command might indicate connectivity problems, credentials problems, or any number of other problems regarding the variable values you supplied. (Remember, your computer [does need to be connected](http://www.macstadium.com/blog/how-to-setup-a-cisco-vpn-connection-in-mac-os-x-and-windows/) to your MacStadium Cisco IPSec VPN.) To the extent you are able, remedy any issues, and try `terraform plan` again.


If and when the `terraform plan` is successful, you should see something like this:

```
Plan: 21 to add, 0 to change, 0 to destroy.
```

Okay, great! You can now proceed to `terraform apply`, which will actually create resources and configure infrastructure. (Note that this will create real resources in AWS, which will incur costs from AWS.) Just as you did with `terraform plan` you will want to use your own custom variables values when running `terraform apply`:

```bash
terraform apply -var-file=my-variables.hcl
```

While the actual configuration process and specific resources created will vary based on the custom variables values you supplied, in any event, this will take some time. Terraform provides reasonably verbose output during all of its activity.

Just as with the `terraform plan`, if and when the process completes successfully, you should expect to see something like this:

```
Apply complete! Resources: 21 added, 0 changed, 0 destroyed.
```

At this point, your VPN between your AWS VPC and your MacStadium Hosted Mac Private Cloud should be fully configured, up and running, and ready for traffic between the two networks.

If, perhaps, you were only testing and now want to reverse the whole process, you can run `terraform destroy` to cleanly destroy all resources and remove all configurations Terraform created (including configuration of your MacStadium Cisco firewall):

```bash
terraform destroy -var-file=my-variables.hcl
```

Step 3: Profit
--------------

Nice work! There is no Step 3.

Appendix: Reference List of Variables
-------------------------------------

- [`needed_in_aws`](#variable-needed_in_aws)
- [`aws_vpc_cidr`](#variable-aws_vpc_cidr)
- [`existing_vpc_id`](#variable-existing_vpc_id)
- [`existing_vgw_id`](#variable-existing_vgw_id)
- [`vpc_route_table_ids`](#variable-vpc_route_table_ids)
- [`aws_region`](#variable-aws_region)
- [`aws_access_key`](#variable-aws_access_key)
- [`aws_secret_key`](#variable-aws_secret_key)
- [`macstadium_cidr`](#variable-macstadium_cidr)
- [`cisco_inside_1_ip_address`](#variable-cisco_inside_1_ip_address)
- [`cisco_wan_ip_address`](#variable-cisco_wan_ip_address)
- [`cisco_firewall_username`](#variable-cisco_firewall_username)
- [`cisco_firewall_password`](#variable-cisco_firewall_password)
- [`macstadium_vcenter_management_username`](#variable-macstadium_vcenter_management_username)
- [`macstadium_vcenter_management_password`](#variable-macstadium_vcenter_management_password)
- [`macstadium_vcenter_management_ip_address`](#variable-macstadium_vcenter_management_ip_address)
- [`macstadium_vcenter_datacenter_name`](#variable-macstadium_vcenter_datacenter_name)
- [`macstadium_vcenter_cluster_name`](#variable-macstadium_vcenter_cluster_name)
- [`macstadium_vcenter_datastore_name`](#variable-macstadium_vcenter_datastore_name)
- [`create_macstadium_test_instances`](#variable-create_macstadium_test_instances)
- [`macstadium_vcenter_vm_template_name`](#variable-macstadium_vcenter_vm_template_name)
- [`number_of_aws_test_instances`](#variable-number_of_aws_test_instances)
- [`number_of_macstadium_test_instances`](#variable-number_of_macstadium_test_instances)


##### Variable: `needed_in_aws`

This value determines which AWS resources need to be created as part of this automated process. The three supported values are: `create_vpc`, `create_gateway`, and `just_vpn`.

Set to `create_vpc` if you want to create a new AWS VPC, AWS Virtual Private Gateway, AWS VPN, and (optionally) one or more t2.nano Amazon Linux test Instances inside of this new AWS VPC. This is the best option if you currently have no infrastructure in AWS, or if you want to demo or experiment with this automated process.

Set to `create_gateway` if you already have an existing AWS VPC, and you want to create an AWS Virtual Private Gateway and AWS VPN for this already-existing AWS VPC, for which you will supply the VPC ID and one or more already-existing Route Table IDs inside your VPC. (See the [`existing_vpc_id`](#variable-existing_vpc_id) and [`vpc_route_table_ids`](#variable-vpc_route_table_ids) variables below.)

Set to `just vpn` if you already have an existing AWS VPC and AWS Virtual Private Gateway, and you simply want to create an AWS VPN for this already-existing AWS Virtual Private Gateway, for which you will supply the Virtual Private Gateway ID and VPC ID. (See the [`existing_vgw_id`](#variable-existing_vgw_id) and [`existing_vpc_id`](#variable-existing_vpc_id) variables below.)

##### Variable: `aws_vpc_cidr`

If you set the [`needed_in_aws`](#variable-needed_in_aws) variable to `create_gateway` or `just_vpn`, then this is is network for your existing AWS VPC. (This needs to be in CIDR notation, for example: 172.20.0.0/16.)

Otherwise, if you set [`needed_in_aws`](#variable-needed_in_aws) to `create_vpc`, then this is the desired network for your new AWS VPC that will be created. (Again, this needs to be in CIDR notation, for example: 172.20.0.0/16.))


If you set [`needed_in_aws`](#variable-needed_in_aws) to `create_gateway` or `just_vpn`, then you need to provide a VPC ID (for example: `vpc-1234abcd`) of an already-existing VPC (located in the AWS Region you specified).

If you set [`needed_in_aws`](#variable-needed_in_aws) to `create_vpc`, then you may set this to `none`, since a brand new VPC will be automatically created.

##### Variable: `existing_vpc_id`

If you set [`needed_in_aws`](#variable-needed_in_aws) to `create_gateway` or `just_vpn`, then you need to provide a VPC ID (for example: `vpc-1234abcd`) of an already-existing VPC (located in the AWS Region you specified).

If you set [`needed_in_aws`](#variable-needed_in_aws) to `create_vpc`, then you may set this to `none`, since a brand new VPC will be automatically created.

##### Variable: `existing_vgw_id`

If you set [`needed_in_aws`](#variable-needed_in_aws) to `create_gateway` or `just_vpn`, then you need to provide a Virtual Private Gateway ID (for example: `vgw-1234abcd`) of an already-existing Virtual Private Gateway (located in the AWS Region you specified).

If you set [`needed_in_aws`](#variable-needed_in_aws) to `create_vpc` or `create_gateway`, then you may set this to `none`, since a brand new Virtual Private Gateway will be automatically created.

##### Variable: `vpc_route_table_ids`

If you set [`needed_in_aws`](#variable-needed_in_aws) to `create_gateway`, then you need to provide a comma-separated list of already-existing Route Table IDs (for example: `rtb-1234abcd,rtb-9876dcba`) that reside in the VPC you specified in [`existing_vpc_id`](#variable-existing_vpc_id). You only need to include the IDs for Route Tables for that you want to include for routing traffic between AWS and MacStadium. If you only have one Route Table in the VPC (or choose to only include one Route Table here), then just specify the single Route Table ID without any commas.

If you set [`needed_in_aws`](#variable-needed_in_aws) to `create_vpc`, then you may set this to `none`, since a brand new Route Table will be automatically created in the brand new VPC which will also be automatically created.

If you set [`needed_in_aws`](#variable-needed_in_aws) to `just_vpn`, then you may also set this to `none`, since only an AWS VPN will by created and simply attached to your already-existing Virtual Private Gateway. Further management of your Route Tables will be your repsonsibility in this scenario.

##### Variable: `aws_region`

AWS Region where your VPC is (or will be) located (for example, `us-east-1`).

##### Variable: `aws_access_key`

AWS Access Key ID for a valid pair of API credentials for your AWS asccount (for example: `AKIAI44QH8DHBEXAMPLE`).

##### Variable: `aws_secret_key`

AWS Secret Key for a valid pair of API credentials for your AWS asccount (for example: `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY`).

##### Variable: `macstadium_cidr`

Network for the Private-1 network of the MacStadium Private Cloud in CIDR notation, (for example: `10.254.20.0/24`), provided by MacStadium in your IP_PLAN document.

##### Variable: `cisco_inside_1_ip_address`

IP address for the Cisco firewall's Inside-1 interface, provided by MacStadium in your IP_PLAN document.

##### Variable: `cisco_wan_ip_address`

IP address for the Cisco firewall's WAN interface, provided by MacStadium in your IP_PLAN document.

##### Variable: `cisco_firewall_username`

Username for the MacStadium Cisco firewall, provided by MacStadium in your IP_PLAN document.

##### Variable: `cisco_firewall_password`

Password for the MacStadium Cisco firewall, provided by MacStadium in your IP_PLAN document.

##### Variable: `macstadium_vcenter_management_username`

Username for MacStadium VCenter management, provided by MacStadium in your IP_PLAN document.

##### Variable: `macstadium_vcenter_management_password`

Password for MacStadium VCenter management, provided by MacStadium in your IP_PLAN document.

##### Variable: `macstadium_vcenter_management_ip_address`

IP address for MacStadium VCenter management, provided by MacStadium in your IP_PLAN document.

##### Variable: `macstadium_vcenter_datacenter_name`

Name of your MacStadium VCenter datacenter, provided by MacStadium, (for example: `MacStadium - VEGAS`).

##### Variable: `macstadium_vcenter_cluster_name`

Name of your MacStadium VCenter cluster, provided by MacStadium, (for example: `XSERVE_Cluster`).

##### Variable: `macstadium_vcenter_datastore_name`

Name of your MacStadium VCenter data store, provided by MacStadium, (for example: `1TB_SSD`).

##### Variable: `create_macstadium_test_instances`

Set to `true` if you want to create test VMs in your MacStadium Private Cloud. Otherwise set to `false`. Note that if you do set this to `true`, you will need an already-existing VM template in your Private Cloud from which to clone these test VMs.

##### Variable: `macstadium_vcenter_vm_template_name`

Name of of a Virtual Machine Template, previously uploaded or created by you in VCenter, (for example: `centos`). If you set [`create_macstadium_test_instances`](#variable-create_macstadium_test_instances) to `false`, then you may set this to `none`.

##### Variable: `number_of_aws_test_instances`

If you set [`needed_in_aws`](#variable-needed_in_aws) to `create_vpc`, then specify the number of Amazon Linux test instances you would like to automatically create inside this new VPC. Note that a brand new private SSH key to access the `ec2-user` account on these Instances will be generated in this directory on your local machine. That key file will be named `macstadium_aws_key`. Also note that if you do not want to create any Amazon Linux test instances in this scenario, you may set this value to 0.

##### Variable: `number_of_macstadium_test_instances`

If you set [`create_macstadium_test_instances`](#variable-create_macstadium_test_instances) to `true`, then specify the number of test VMs you would like to automatically create inside of your MacStadium Private Cloud. This VMs will need to be based on a Virtual Machine Template which you previously have uploaded or created by you in VCenter (see: [`macstadium_vcenter_vm_template_name`](#variable-macstadium_vcenter_vm_template_name)).
