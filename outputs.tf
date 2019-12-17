#
# Compute
#
output "instance" {
  value = aws_instance.main
}

output "aws_instance_private_ip" {
  description = "Contains the instance private IP address."
  value       = aws_instance.main.private_ip
}

output "aws_instance_public_ip" {
  description = "Contains the instance private IP address."
  value       = aws_eip.this.*.public_ip
}

output "aws_instance_type" {
  description = "The type of the Instance."
  value       = aws_instance.main.instance_type
}

output "aws_instance_ami" {
  description = "The AMI of the Instance."
  value       = aws_instance.main.ami
}

output "aws_instance_key_name" {
  description = "The ssh key pair name of the Instance."
  value       = aws_instance.main.key_name
}



output "aws_instance_volume_tags" {
  description = "The root EBS volume tags of the instace."
  value       = aws_instance.main.volume_tags
}

#
# Security
#
output "aws_instance_iam_profile" {
  description = "The IAM instance profile of the EC2."
  value       = aws_instance.main.iam_instance_profile
}

output "aws_instance_assume_role_name" {
  description = "The IAM instance profile of the EC2."
  value       = var.instance_profile == "" ? aws_iam_role.basic_instance_assume_role[0].name : ""
}

output "security_group" {
  value = aws_security_group.main
}

#
# DNS
#
output "dns_record_private" {
  value = aws_route53_record.main_private.*.name
}

output "dns_record_public" {
  value = aws_route53_record.main_public.*.name
}