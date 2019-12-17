# Terraform Module: AWS EC2 Basic Layout

## Overview

This module could be useful if you find yourself creating a layout that includes the following resources:

* EC2 Instance w/ configurable AMI, family type, key pair, networking, userdata, among others.
* EC2 Profile with a customizable IAM Role supporting both AWS and customer managed policies.
* Multiple EBS dynamic blocks (root_block_device, ebs_block_device and ephemeral_block_device) w/ configurable type, size, device name and encryption configs among others.
* Security group for the instance above.
* Optionally associate a public IP address with the instance.
* DNS record with a record that points to the instance private IP / public IP.
* Tags: both EC2 and EBS.

Personally we have seen the need of creating a similar set of such resources for an OpenVPN instance, for Jenkins, Spinnaker, DroneCI, Prometheus, Grafana, Hashicorp Vault, ElasticSearch, Kibana and so forth.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| associate\_public\_ip\_address | Associate a public IP address with the instance | bool | `"true"` | no |
| aws\_ami\_os\_id | AWS AMI Operating System Identificator | string | `"ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"` | no |
| aws\_ami\_os\_owner | AWS AMI Operating System Owner, eg: 099720109477 for Canonical | string | `"099720109477"` | no |
| aws\_userdata\_path | AWS EC2 userdata provisioning script path | string | `"./provisioner/aws-userdata/userdata.sh"` | no |
| dev\_account\_id | Dev/Stage Account ID | string | `"111111111111"` | no |
| ebs\_optimized | Enable EBS Optimized | string | `"false"` | no |
| environment | Environment Name | string | `"shared-test"` | no |
| instance\_type | EC2 Instance Type | string | `"t3.micro"` | no |
| monitoring | If true, the launched EC2 instance will have detailed monitoring enabled | bool | `"true"` | no |
| name | Name | string | `"ec2-test"` | no |
| prefix | Prefix | string | `"infra"` | no |
| profile | AWS Profile | string | `"bb-shared-deploymaster"` | no |
| project | Project id | string | `"bb"` | no |
| region | AWS Region | string | `"us-east-1"` | no |
| region\_backend\_data | AWS Region | string | `"us-east-1"` | no |
| root\_device\_backup\_tag | EC2 Root Block Device backup tag | string | `"True"` | no |
| shared\_account\_id | Account: Shared Resources | string | `"222222222222"` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_instance\_ami | The AMI of the Instance. |
| aws\_instance\_assume\_role\_name | The IAM instance role name of the EC2. |
| aws\_instance\_az | The availability zone of the instance |
| aws\_instance\_iam\_profile | The IAM instance profile of the EC2. |
| aws\_instance\_key\_name | The ssh key pair name of the Instance. |
| aws\_instance\_private\_ip | Contains the private IP address. |
| aws\_instance\_public\_dns | The public DNS name assigned to the instance. |
| aws\_instance\_public\_ip | Contains the private IP address. |
| aws\_instance\_type | The type of the Instance. |
| aws\_instance\_volume\_tags | The root EBS volume tags of the instace. |
| dns\_record\_private | DNS |
| dns\_record\_public |  |
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
