#
# Terraform outputs
#
#
# Compute
#
output "aws_instance_public_dns" {
  description = "The public DNS name assigned to the instance."
  value       = module.terraform-aws-basic-layout.instance.public_dns
}

output "aws_instance_az" {
  description = "The availability zone of the instance"
  value       = module.terraform-aws-basic-layout.instance.availability_zone
}

output "aws_instance_private_ip" {
  description = "Contains the private IP address."
  value       = module.terraform-aws-basic-layout.aws_instance_private_ip
}

output "aws_instance_public_ip" {
  description = "Contains the private IP address."
  value       = module.terraform-aws-basic-layout.aws_instance_public_ip
}


output "aws_instance_type" {
  description = "The type of the Instance."
  value       = module.terraform-aws-basic-layout.aws_instance_type
}

output "aws_instance_ami" {
  description = "The AMI of the Instance."
  value       = module.terraform-aws-basic-layout.aws_instance_ami
}

output "aws_instance_volume_tags" {
  description = "The root EBS volume tags of the instace."
  value       = module.terraform-aws-basic-layout.aws_instance_volume_tags
}

#
# Security
#
output "aws_instance_key_name" {
  description = "The ssh key pair name of the Instance."
  value       = module.terraform-aws-basic-layout.aws_instance_key_name
}

output "aws_instance_iam_profile" {
  description = "The IAM instance profile of the EC2."
  value       = module.terraform-aws-basic-layout.aws_instance_iam_profile
}

output "aws_instance_assume_role_name" {
  description = "The IAM instance role name of the EC2."
  value       = module.terraform-aws-basic-layout.aws_instance_assume_role_name
}

output "security_group" {
  value = module.terraform-aws-basic-layout.security_group
}

#
# DNS
#
output "dns_record_private" {
  value = module.terraform-aws-basic-layout.dns_record_private
}

output "dns_record_public" {
  value = module.terraform-aws-basic-layout.dns_record_public
}