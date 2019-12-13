<div align="center">
    <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-ec2-basic-layout/master/figures/binbash.png" alt="drawing" width="350"/>
</div>
<div align="right">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-ec2-basic-layout/master/figures/binbash-leverage-terraform.png" alt="leverage" width="230"/>
</div>

# Terraform Module: AWS EC2 Basic Layout

## Overview
This module could be useful if you find yourself creating a layout that includes the following resources:
* EC2 Instance
* Security group for the instance above
* DNS record with a record that points to the instance private IP

Personally I have seen the need of creating a similar set of such resources for an OpenVPN instance, for Jenkins, Spinnaker, DroneCI, and so forth.

## Roadmap
* Add examples folder

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| key\_pair\_name | Key Pair Name | string | n/a | yes |
| subnet\_id | Subnet ID | string | n/a | yes |
| vpc\_id | VPC ID | string | n/a | yes |
| ami\_id | AMI Identifier | string | `""` | no |
| associate\_public\_ip\_address | Associate a public IP address with the instance | bool | `"false"` | no |
| aws\_ami\_os\_id | AWS AMI Operating System Identificator | string | `"ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"` | no |
| aws\_ami\_os\_owner | AWS AMI Operating System Owner, eg: 099720109477 for Canonical | string | `"099720109477"` | no |
| dns\_records | A list of DNS records to create with the instance's IP | list(any) | `[]` | no |
| ebs\_optimized | Enable EBS Optimized | string | `"false"` | no |
| instance\_profile | EC2 IAM Instance Profile | string | `""` | no |
| instance\_type | EC2 Instance Type | string | `"t3.micro"` | no |
| name | Name | string | `"default"` | no |
| prefix | Prefix | string | `"default"` | no |
| root\_device\_backup\_tag | EC2 Root Block Device backup tag | bool | `"true"` | no |
| root\_device\_encrypted | EC2 Root Block Device Encrypted | bool | `"true"` | no |
| root\_device\_volume\_size | EC2 Root Block Device Volume Size | number | `"8"` | no |
| root\_device\_volume\_type | EC2 Root Block Device Volume Type | string | `"gp2"` | no |
| security\_group\_rules | A list of security group rules | list(any) | `[]` | no |
| tags | Tags | map | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_instance\_ami | The AMI of the Instance. |
| aws\_instance\_iam\_profile | The IAM instance profile of the EC2. |
| aws\_instance\_key\_name | The ssh key pair name of the Instance. |
| aws\_instance\_private\_ip | Contains the instance private IP address. |
| aws\_instance\_public\_ip | Contains the instance private IP address. |
| aws\_instance\_type | The type of the Instance. |
| aws\_instance\_volume\_tags | The root EBS volume tags of the instace. |
| dns\_record\_private | DNS |
| dns\_record\_public |  |
| instance | Compute |
| security\_group |  |


## Examples
### EC2 Pritunl VPN
#### ec2-basic-layout
```terraform
#
# EC2 basic layout
#

module "terraform-aws-basic-layout" {
    source = "git::git@github.com:binbashar/terraform-aws-ec2-basic-layout.git?ref=v0.2.2"

    prefix                      = var.prefix
    name                        = var.name

    aws_ami_os_id               = var.aws_ami_os_id
    aws_ami_os_owner            = var.aws_ami_os_owner
    instance_type               = var.instance_type
    instance_profile            = aws_iam_instance_profile.basic_instance.name
    vpc_id                      = data.terraform_remote_state.vpc.outputs.vpc_id
    subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnets[0]
    associate_public_ip_address = var.associate_public_ip_address
    key_pair_name               = data.terraform_remote_state.security.outputs.aws_key_pair_name
    root_device_volume_type     = var.root_device_volume_type
    ebs_optimized               = var.ebs_optimized
    root_device_volume_size     = var.root_device_volume_size
    root_device_encrypted       = var.root_device_encrypted

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

    dns_records = [{
        zone_id = data.terraform_remote_state.vpc.outputs.aws_public_zone_id[0],
        name    = "ec2-basic-layout.binbash.com.ar",
        type    = "A",
        ttl     = 300
    }]

    tags = local.tags
}
```

---

# Release Management

## Docker based makefile commands
- https://cloud.docker.com/u/binbash/repository/docker/binbash/git-release
- https://github.com/binbashar/terraform-aws-ec2-basic-layout/blob/master/Makefile

Root directory `Makefile` has the automated steps (to be integrated with **CircleCI jobs** []() )

### CircleCi PR auto-release job
<div align="left">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-ec2-basic-layout/master/figures/circleci.png" alt="leverage-circleci" width="230"/>
</div>

- https://circleci.com/gh/binbashar/terraform-aws-ec2-basic-layout
- **NOTE:** Will only run after merged PR.

### Manual execution from workstation
```
$ make
Available Commands:
 - release-major-with-changelog make changelog-major && git add && git commit && make release-major
 - release-minor-with-changelog make changelog-minor && git add && git commit && make release-minor
 - release-patch-with-changelog make changelog-patch && git add && git commit && make release-patch