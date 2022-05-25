#==============================#
# Project Variables            #
#==============================#
variable "project" {
  description = "Project id"
  default     = "bb"
}

variable "environment" {
  description = "Environment Name"
  default     = "shared-test"
}

#=============================#
# External Accounts Data      #
#=============================#
variable "dev_account_id" {
  description = "Dev/Stage Account ID"
  default     = "111111111111"
}

variable "shared_account_id" {
  description = "Account: Shared Resources"
  default     = "222222222222"
}

#=============================#
# EC2 BASIC LAYOUT MODULE     #
#=============================#
#
# General
#
variable "prefix" {
  type        = string
  description = "Prefix"
  default     = "infra"
}

variable "name" {
  type        = string
  description = "Name"
  default     = "ec2-test"
}

#
# EC2 Attributes
#
variable "aws_ami_os_id" {
  description = "AWS AMI Operating System Identificator"
  default     = "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"
}

variable "aws_ami_os_owner" {
  description = "AWS AMI Operating System Owner, eg: 099720109477 for Canonical "
  default     = "099720109477"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
  default     = "t3.micro"
}

variable "ebs_optimized" {
  type        = string
  description = "Enable EBS Optimized"
  default     = "false"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address with the instance"
  default     = true
}

variable "root_device_backup_tag" {
  type        = string
  description = "EC2 Root Block Device backup tag"
  default     = "True"
}

variable "monitoring" {
  type        = bool
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = true
}

variable "aws_userdata_path" {
  description = "AWS EC2 userdata provisioning script path"
  default     = "./provisioner/aws-userdata/userdata.sh"
}