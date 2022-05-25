# Terraform Module: AWS EC2 Basic Layout with SSM support

## Overview

This module could be useful if you find yourself creating a layout with SSM access support wither via browser or via AWS CLI.

#### AWS CLI instructions

You would need to set AWS credentials either via SSO or IAM and then run:

```$ export AWS_SHARED_CREDENTIALS_FILE="~/.aws/credentials"
$ export AWS_CONFIG_FILE="~/.aws/config"
$ aws ssm start-session --target INSTANCE_ID```

For more detailed information, please refer to the following resources:
* [AWS CLI command reference](https://docs.aws.amazon.com/cli/latest/reference/ssm/)
* [AWS SSM start a session](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-sessions-start.html)

#### ec2-default-instance-profile-ssm

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
    enable_ssm_access           = local.enable_ssm_access

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