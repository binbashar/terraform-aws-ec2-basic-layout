<div align="center">
    <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-ec2-basic-layout/master/figures/binbash-logo.png" alt="binbash" width="250"/>
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
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ami\_id | AMI Identifier | string | `""` | no |
| associate\_public\_ip\_address | Associate a public IP address with the instance | bool | `"false"` | no |
| aws\_ami\_os\_id | AWS AMI Operating System Identificator | string | `"ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"` | no |
| aws\_ami\_os\_owner | AWS AMI Operating System Owner, eg: 099720109477 for Canonical | string | `"099720109477"` | no |
| credit\_specification\_cpu | Can be applied/modified to the EC2 at any time. The credit option for CPU usage. Can be 'standard' or 'unlimited'. By default T3 = unlimited & T2 'standard'. | string | `"unlimited"` | no |
| cross\_account\_roles\_resource\_arn\_list | Resources arn list for cross org roles for EC2 profile IAM Role policy. | list(string) | `[]` | no |
| disable\_api\_termination | If true, enables EC2 Instance Termination Protection | string | `"false"` | no |
| dns\_records\_internal\_hosted\_zone | A list of DNS private (internal hosted zone) records to create with the instance's IP | list(any) | `[]` | no |
| dns\_records\_public\_hosted\_zone | A list of DNS public (public hosted zone) records to create with the instance's IP | list(any) | `[]` | no |
| ebs\_block\_device | Additional EBS block devices to attach to the instance | list(map(string)) | `[]` | no |
| ebs\_optimized | Enable EBS Optimized | string | `"false"` | no |
| ephemeral\_block\_device | Customize Ephemeral (also known as Instance Store) volumes on the instance | list(map(string)) | `[]` | no |
| instance\_profile | The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. | string | `""` | no |
| instance\_type | EC2 Instance Type | string | `"t3.micro"` | no |
| key\_pair\_name | Key Pair Name | string | n/a | yes |
| monitoring | If true, the launched EC2 instance will have detailed monitoring enabled | bool | `"false"` | no |
| name | Name | string | n/a | yes |
| policy\_acctions\_list | Action list for EC2 profile IAM Role policy. | list(string) | `[]` | no |
| policy\_arn | Attach AWS IAM managed policies to the IAM Role. | list(string) | `[]` | no |
| prefix | Prefix | string | `"default"` | no |
| root\_block\_device | Customize details about the root block device of the instance. See Block Devices below for details | list(map(string)) | `[]` | no |
| root\_device\_backup\_tag | EC2 Root Block Device backup tag | string | `"True"` | no |
| security\_group\_rules | A list of security group rules | list(any) | `[]` | no |
| subnet\_id | Subnet ID | string | n/a | yes |
| tags | Tags | map(string) | `{}` | no |
| user\_data | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead. | string | `"null"` | no |
| user\_data\_base64 | Can be used instead of user_data to pass base64-encoded binary data directly. Use this instead of user_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption. | string | `"null"` | no |
| vpc\_id | VPC ID | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_instance\_ami | The AMI of the Instance. |
| aws\_instance\_assume\_role\_name | The IAM instance profile of the EC2. |
| aws\_instance\_iam\_profile | The IAM instance profile of the EC2. |
| aws\_instance\_key\_name | The ssh key pair name of the Instance. |
| aws\_instance\_private\_ip | Contains the instance private IP address. |
| aws\_instance\_public\_ip | Contains the instance public IP address. |
| aws\_instance\_type | The type of the Instance. |
| aws\_instance\_volume\_tags | The root EBS volume tags of the instace. |
| dns\_record\_private | DNS |
| dns\_record\_public |  |
| instance | Compute |
| security\_group |  |

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
    policy_acctions_list = [
        "ecr:*",
        "ssm:*",
        "route53:*",
        "s3:ListBucket",
        "s3:PutObject",
        "s3:PutObjectAcl",
        "s3:GetObject",
        "s3:DeleteObject"
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

# Release Management
### CircleCi PR auto-release job

<div align="left">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-ec2-basic-layout/master/figures/circleci-logo.png" alt="circleci" width="130"/>
</div>

- [**pipeline-job**](https://circleci.com/gh/binbashar/terraform-aws-ec2-basic-layout) (**NOTE:** Will only run after merged PR)
- [**releases**](https://github.com/binbashar/terraform-aws-ec2-basic-layout/releases)
- [**changelog**](https://github.com/binbashar/terraform-aws-ec2-basic-layout/blob/master/CHANGELOG.md)
