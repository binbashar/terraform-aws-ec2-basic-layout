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
  type        = string
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  default     = null
}

variable "user_data_base64" {
  type        = string
  description = "Can be used instead of user_data to pass base64-encoded binary data directly. Use this instead of user_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption."
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

variable "tagApprovedAMIvalue" {
  type        = string
  description = "Set the specific tag ApprovedAMI ('true' | 'false') that identifies aws-config compliant AMIs"
  default     = "false"
}

variable "root_device_backup_tag" {
  type        = string
  description = "EC2 Root Block Device backup tag"
  default     = "True"
}

variable "root_block_device" {
  type        = list(map(string))
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  default     = []
}

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

variable "policy_arn" {
  type        = list(string)
  description = "Attach AWS IAM managed policies to the IAM Role."
  default     = []
}

variable "cross_account_roles_resource_arn_list" {
  type        = list(string)
  description = "Resources arn list for cross org roles for EC2 profile IAM Role policy."
  default     = []
}

variable "security_group_rules" {
  type        = list(any)
  description = "A list of security group rules"
  default     = []
}

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

variable "credit_specification_cpu" {
  type        = string
  description = "Can be applied/modified to the EC2 at any time. The credit option for CPU usage. Can be 'standard' or 'unlimited'. By default T3 = unlimited & T2 'standard'."
  default     = "unlimited"
}

variable "disable_api_termination" {
  type        = string
  description = "If true, enables EC2 Instance Termination Protection"
  default     = "false"
}
