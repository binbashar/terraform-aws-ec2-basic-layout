<div align="center">
    <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-ec2-basic-layout/master/figures/binbash-logo.png"
     alt="binbash" width="250"/>
</div>
<div align="right">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-ec2-basic-layout/master/figures/binbash-leverage-terraform-logo.png"
  alt="leverage" width="130"/>
</div>

# Terraform Module: AWS EC2 Basic Layout

## Overview

This module could be useful if you find yourself creating a layout that includes
the following resources:

* EC2 Instance w/ configurable AMI, family type, key pair, networking, userdata,
among others.
* EC2 Profile with a customizable IAM Role supporting both AWS and customer
 managed policies.
* Multiple EBS dynamic blocks (root_block_device, ebs_block_device and
 ephemeral_block_device) w/ configurable type, size, device name and encryption
 configs among others.
* Security group for the instance above.
* Optionally associate a public IP address with the instance.
* DNS record with a record that points to the instance private IP / public IP.
* Tags: both EC2 and EBS.

Personally we have seen the need of creating a similar set of such resources
 for an OpenVPN instance, for Jenkins, Spinnaker, DroneCI, Prometheus, Grafana,
 Hashicorp Vault, ElasticSearch, Kibana and so forth.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_iam_instance_profile.basic_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.cross_org_instance_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.basic_instance_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.basic_instance_aws_roles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ec2_ssm_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_route53_record.main_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.main_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress_allow_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ami.ubuntu_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_iam_policy_document.cross_org_instance_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI Identifier | `string` | `""` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Associate a public IP address with the instance | `bool` | `false` | no |
| <a name="input_aws_ami_os_id"></a> [aws\_ami\_os\_id](#input\_aws\_ami\_os\_id) | AWS AMI Operating System Identificator | `string` | `"ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"` | no |
| <a name="input_aws_ami_os_owner"></a> [aws\_ami\_os\_owner](#input\_aws\_ami\_os\_owner) | AWS AMI Operating System Owner, eg: 099720109477 for Canonical | `string` | `"099720109477"` | no |
| <a name="input_credit_specification_cpu"></a> [credit\_specification\_cpu](#input\_credit\_specification\_cpu) | Can be applied/modified to the EC2 at any time. The credit option for CPU usage. Can be 'standard' or 'unlimited'. By default T3 = unlimited & T2 'standard'. | `string` | `"unlimited"` | no |
| <a name="input_cross_account_roles_resource_arn_list"></a> [cross\_account\_roles\_resource\_arn\_list](#input\_cross\_account\_roles\_resource\_arn\_list) | Resources arn list for cross org roles for EC2 profile IAM Role policy. | `list(string)` | `[]` | no |
| <a name="input_disable_api_termination"></a> [disable\_api\_termination](#input\_disable\_api\_termination) | If true, enables EC2 Instance Termination Protection | `string` | `"false"` | no |
| <a name="input_dns_records_internal_hosted_zone"></a> [dns\_records\_internal\_hosted\_zone](#input\_dns\_records\_internal\_hosted\_zone) | A list of DNS private (internal hosted zone) records to create with the instance's IP | `list(any)` | `[]` | no |
| <a name="input_dns_records_public_hosted_zone"></a> [dns\_records\_public\_hosted\_zone](#input\_dns\_records\_public\_hosted\_zone) | A list of DNS public (public hosted zone) records to create with the instance's IP | `list(any)` | `[]` | no |
| <a name="input_ebs_block_device"></a> [ebs\_block\_device](#input\_ebs\_block\_device) | Additional EBS block devices to attach to the instance | `list(map(string))` | `[]` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | Enable EBS Optimized | `string` | `"false"` | no |
| <a name="input_enable_ssm_access"></a> [enable\_ssm\_access](#input\_enable\_ssm\_access) | If true, attaches SSM policy to instance role | `string` | `"false"` | no |
| <a name="input_ephemeral_block_device"></a> [ephemeral\_block\_device](#input\_ephemeral\_block\_device) | Customize Ephemeral (also known as Instance Store) volumes on the instance | `list(map(string))` | `[]` | no |
| <a name="input_instance_profile"></a> [instance\_profile](#input\_instance\_profile) | The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 Instance Type | `string` | `"t3.micro"` | no |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | Key Pair Name | `string` | n/a | yes |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | If true, the launched EC2 instance will have detailed monitoring enabled | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name | `string` | n/a | yes |
| <a name="input_policy_arn"></a> [policy\_arn](#input\_policy\_arn) | Attach AWS IAM managed policies to the IAM Role. | `list(string)` | `[]` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix | `string` | `"default"` | no |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | Customize details about the root block device of the instance. See Block Devices below for details | `list(map(string))` | `[]` | no |
| <a name="input_root_device_backup_tag"></a> [root\_device\_backup\_tag](#input\_root\_device\_backup\_tag) | EC2 Root Block Device backup tag | `string` | `"True"` | no |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | A list of security group rules | `list(any)` | `[]` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID | `string` | n/a | yes |
| <a name="input_tag_approved_ami_value"></a> [tag\_approved\_ami\_value](#input\_tag\_approved\_ami\_value) | Set the specific tag ApprovedAMI ('true' \| 'false') that identifies aws-config compliant AMIs | `string` | `"false"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `map(string)` | `{}` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user\_data\_base64 instead. | `string` | `null` | no |
| <a name="input_user_data_base64"></a> [user\_data\_base64](#input\_user\_data\_base64) | Can be used instead of user\_data to pass base64-encoded binary data directly. Use this instead of user\_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption. | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_instance_ami"></a> [aws\_instance\_ami](#output\_aws\_instance\_ami) | The AMI of the Instance. |
| <a name="output_aws_instance_assume_role_name"></a> [aws\_instance\_assume\_role\_name](#output\_aws\_instance\_assume\_role\_name) | The IAM instance profile of the EC2. |
| <a name="output_aws_instance_iam_profile"></a> [aws\_instance\_iam\_profile](#output\_aws\_instance\_iam\_profile) | The IAM instance profile of the EC2. |
| <a name="output_aws_instance_key_name"></a> [aws\_instance\_key\_name](#output\_aws\_instance\_key\_name) | The ssh key pair name of the Instance. |
| <a name="output_aws_instance_private_ip"></a> [aws\_instance\_private\_ip](#output\_aws\_instance\_private\_ip) | Contains the instance private IP address. |
| <a name="output_aws_instance_public_ip"></a> [aws\_instance\_public\_ip](#output\_aws\_instance\_public\_ip) | Contains the instance public IP address. |
| <a name="output_aws_instance_type"></a> [aws\_instance\_type](#output\_aws\_instance\_type) | The type of the Instance. |
| <a name="output_aws_instance_volume_tags"></a> [aws\_instance\_volume\_tags](#output\_aws\_instance\_volume\_tags) | The root EBS volume tags of the instace. |
| <a name="output_dns_record_private"></a> [dns\_record\_private](#output\_dns\_record\_private) | DNS |
| <a name="output_dns_record_public"></a> [dns\_record\_public](#output\_dns\_record\_public) | n/a |
| <a name="output_instance"></a> [instance](#output\_instance) | Compute |
| <a name="output_security_group"></a> [security\_group](#output\_security\_group) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Examples

### EC2 Basic Layout

#### ec2-default-instance-profile-simple

```terraform
module "terraform-aws-basic-layout" {
  source = "../../"

  vpc_id                      = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  key_pair_name               = data.terraform_remote_state.security.outputs.aws_key_pair_name
}
```

#### ec2-default-instance-profile

```terraform
module "terraform-aws-basic-layout" {
    source = "../../"

    prefix                      = var.prefix
    name                        = var.name

    aws_ami_os_id               = var.aws_ami_os_id
    aws_ami_os_owner            = var.aws_ami_os_owner
    instance_type               = var.instance_type
    vpc_id                      = data.terraform_remote_state.vpc.outputs.vpc_id
    subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnets[0]
    associate_public_ip_address = var.associate_public_ip_address
    key_pair_name               = data.terraform_remote_state.security.outputs.aws_key_pair_name
    ebs_optimized               = var.ebs_optimized
    monitoring                  = var.monitoring
    user_data_base64            = base64encode(local.user_data)

    root_block_device = [
        {
            volume_type = "gp2"
            volume_size = 10
            encrypted   = true
        },
    ]

    ebs_block_device = [
        {
            device_name = "/dev/sdf"
            volume_type = "gp2"
            volume_size = 5
            encrypted   = true
        },
        {
            device_name = "/dev/sdg"
            volume_type = "gp2"
            volume_size = 5
            encrypted   = true
        }
    ]


    security_group_rules = [
        {
            from_port   = 22,
            to_port     = 22,
            protocol    = "tcp",
            cidr_blocks = [ data.terraform_remote_state.vpc.outputs.vpc_cidr_block ],
            description = "Allow SSH"
        },
        {
            from_port   = 8080,
            to_port     = 8082,
            protocol    = "tcp",
            cidr_blocks = [ "0.0.0.0/0" ],
            description = "Allow nginx proxy"
        }
    ]

    dns_records_internal_hosted_zone = [{
        zone_id = data.terraform_remote_state.vpc.outputs.aws_internal_zone_id[0],
        name    = "ec2-basic-layout.aws.binbash.com.ar",
        type    = "A",
        ttl     = 300
    }]

    dns_records_public_hosted_zone = [{
        zone_id = data.terraform_remote_state.vpc.outputs.aws_public_zone_id[0],
        name    = "ec2-basic-layout.binbash.com.ar",
        type    = "A",
        ttl     = 300
    }]

    # EC2 IAM Profile (Role + Policies)
    cross_account_roles_resource_arn_list = [
        "arn:aws:iam::${var.dev_account_id}:role/DevOps",
        "arn:aws:iam::${var.shared_account_id}:role/DevOps",
        "arn:aws:iam::${var.dev_account_id}:role/Auditor",
        "arn:aws:iam::${var.shared_account_id}:role/Auditor",
    ]
    policy_arn = [
        "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
        "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
    ]

    tags = local.tags
}
```

#### ec2-external-instance-profile

```terraform
module "terraform-aws-basic-layout" {
    source = "../../"

    prefix                      = var.prefix
    name                        = var.name

    aws_ami_os_id               = var.aws_ami_os_id
    aws_ami_os_owner            = var.aws_ami_os_owner
    instance_type               = var.instance_type
    vpc_id                      = data.terraform_remote_state.vpc.outputs.vpc_id
    subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnets[0]
    associate_public_ip_address = var.associate_public_ip_address
    key_pair_name               = data.terraform_remote_state.security.outputs.aws_key_pair_name
    ebs_optimized               = var.ebs_optimized
    monitoring                  = var.monitoring
    user_data_base64            = base64encode(local.user_data)

    root_block_device = [
        {
            volume_type = "gp2"
            volume_size = 10
            encrypted   = true
        },
    ]

    ebs_block_device = [
        {
            device_name = "/dev/sdf"
            volume_type = "gp2"
            volume_size = 5
            encrypted   = true
        },
        {
            device_name = "/dev/sdg"
            volume_type = "gp2"
            volume_size = 5
            encrypted   = true
        }
    ]


    security_group_rules = [
        {
            from_port   = 22,
            to_port     = 22,
            protocol    = "tcp",
            cidr_blocks = [ data.terraform_remote_state.vpc.outputs.vpc_cidr_block ],
            description = "Allow SSH"
        },
        {
            from_port   = 8080,
            to_port     = 8082,
            protocol    = "tcp",
            cidr_blocks = [ "0.0.0.0/0" ],
            description = "Allow nginx proxy"
        }
    ]

    dns_records_internal_hosted_zone = [{
        zone_id = data.terraform_remote_state.vpc.outputs.aws_internal_zone_id[0],
        name    = "ec2-basic-layout.aws.binbash.com.ar",
        type    = "A",
        ttl     = 300
    }]

    dns_records_public_hosted_zone = [{
        zone_id = data.terraform_remote_state.vpc.outputs.aws_public_zone_id[0],
        name    = "ec2-basic-layout.binbash.com.ar",
        type    = "A",
        ttl     = 300
    }]

    # EC2 IAM Profile (Role + Policies)
    instance_profile = aws_iam_instance_profile.basic_instance_profile.name

    tags = local.tags
}
```

---

## Binbash Leverage | DevOps Automation Code Library Integration

In order to get the full automated potential of the
[Binbash Leverage DevOps Automation Code Library](https://leverage.binbash.com.ar/how-it-works/code-library/code-library/)  
you should initialize all the necessary helper **Makefiles**.

#### How?
You must execute the `make init-makefiles` command  at the root context

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-backup-by-tags on master✔ 20-09-17
╰─⠠⠵ make
Available Commands:
 - init-makefiles     initialize makefiles

```

### Why?
You'll get all the necessary commands to automatically operate this module via a dockerized approach,
example shown below

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-backup-by-tags on master✔ 20-09-17
╰─⠠⠵ make
Available Commands:
 - circleci-validate-config  ## Validate A CircleCI Config (https
 - format-check        ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
 - format              ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
 - tf-dir-chmod        ## run chown in ./.terraform to gran that the docker mounted dir has the right permissions
 - version             ## Show terraform version
 - init-makefiles      ## initialize makefiles
```

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-backup-by-tags on master✔ 20-09-17
╰─⠠⠵ make format-check
docker run --rm -v /home/delivery/Binbash/repos/Leverage/terraform/terraform-aws-backup-by-tags:"/go/src/project/":rw -v :/config -v /common.config:/common-config/common.config -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/etc/gitconfig -v ~/.aws/bb:/root/.aws/bb -e AWS_SHARED_CREDENTIALS_FILE=/root/.aws/bb/credentials -e AWS_CONFIG_FILE=/root/.aws/bb/config --entrypoint=/bin/terraform -w "/go/src/project/" -it binbash/terraform-awscli-slim:0.12.28 fmt -check
```

# Release Management
### CircleCi PR auto-release job

<div align="left">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-ec2-basic-layout/master/figures/circleci-logo.png"
   alt="circleci" width="130"/>
</div>

- [**pipeline-job**](https://circleci.com/gh/binbashar/terraform-aws-ec2-basic-layout) (**NOTE:** Will only run after merged PR)
- [**releases**](https://github.com/binbashar/terraform-aws-ec2-basic-layout/releases)
- [**changelog**](https://github.com/binbashar/terraform-aws-ec2-basic-layout/blob/master/CHANGELOG.md)
