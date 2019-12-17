#
# General
#
variable "prefix" {
  type        = string
  description = "Prefix"
  default     = "default"
}

variable "name" {
  type        = string
  description = "Name"
  default     = "default"
}

#
# EC2 Attributes
#
variable "ami_id" {
  type        = string
  description = "AMI Identifier"
  default     = ""
}

variable "aws_ami_os_id" {
  type        = string
  description = "AWS AMI Operating System Identificator"
  default     = "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"
}

variable "aws_ami_os_owner" {
  type        = string
  description = "AWS AMI Operating System Owner, eg: 099720109477 for Canonical "
  default     = "099720109477"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
  default     = "t3.micro"
}

variable "instance_profile" {
  type        = string
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
  default     = ""
}

variable "ebs_optimized" {
  type        = string
  description = "Enable EBS Optimized"
  default     = "false"
}

variable "monitoring" {
  type        = bool
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = false
}

variable "user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "Can be used instead of user_data to pass base64-encoded binary data directly. Use this instead of user_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption."
  type        = string
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address with the instance"
  default     = false
}

variable "key_pair_name" {
  type        = string
  description = "Key Pair Name"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}

variable "root_device_backup_tag" {
  type        = string
  description = "EC2 Root Block Device backup tag"
  default     = "True"
}

#root_block_device = [
#    {
#        volume_type = "gp2"
#        volume_size = 10
#        encrypted   = true
#    },
#
variable "root_block_device" {
  type        = list(map(string))
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  default     = []
}

#ebs_block_device = [
#    {
#        device_name = "/dev/sdf"
#        volume_type = "gp2"
#        volume_size = 5
#        encrypted   = true
#    },
#    {
#        device_name = "/dev/sdg"
#        volume_type = "gp2"
#        volume_size = 5
#        encrypted   = true
#    }
#]
#
variable "ebs_block_device" {
  type        = list(map(string))
  description = "Additional EBS block devices to attach to the instance"
  default     = []
}

variable "ephemeral_block_device" {
  type        = list(map(string))
  description = "Customize Ephemeral (also known as Instance Store) volumes on the instance"
  default     = []
}

#
# EC2 Profile
#
# policy_arn = [
#  "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
#   "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
# ]
#
variable "policy_arn" {
  description = "Attach AWS IAM managed policies to the IAM Role."
  type        = list(string)
  default     = []
}

#policy_acctions_list = [
#  "ecr:*",
#  "ssm:*",
#  "route53:*",
#  "s3:ListBucket",
#  "s3:PutObject",
#  "s3:PutObjectAcl",
#  "s3:GetObject",
#  "s3:DeleteObject"
#]
variable "policy_acctions_list" {
  description = "Action list for EC2 profile IAM Role policy."
  type        = list(string)
  default     = []
}


#resource_arn_list = [
#    "arn:aws:iam::111111111111:role/DevOps",
#    "arn:aws:iam::111111111111:role/DevOps",
#    "arn:aws:iam::222222222222:role/Auditor",
#    "arn:aws:iam::222222222222:role/Auditor",
#]
variable "cross_account_roles_resource_arn_list" {
  description = "Resources arn list for cross org roles for EC2 profile IAM Role policy."
  type        = list(string)
  default     = []
}

#
# Security Group Rules -- For example:
#   security_group_rules = [{
#       from_port   = 22,
#       to_port     = 22,
#       protocol    = "tcp",
#       cidr_blocks = [ "0.0.0.0/0" ],
#       description = "Allow SSH"
#   }]
#
variable "security_group_rules" {
  type        = list(any)
  description = "A list of security group rules"
  default     = []
}

#
# DNS Records -- For example:
#   dns_records = [{
#       zone_id = "ABCDEF123",
#       name    = "some.example.com",
#       type    = "A",
#       ttl     = 3600
#   }]
#
variable "dns_records_internal_hosted_zone" {
  type        = list(any)
  description = "A list of DNS private (internal hosted zone) records to create with the instance's IP"
  default     = []
}

variable "dns_records_public_hosted_zone" {
  type        = list(any)
  description = "A list of DNS public (public hosted zone) records to create with the instance's IP"
  default     = []
}