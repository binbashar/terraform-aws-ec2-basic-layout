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
}
variable "instance_type" {
    type        = string
    description = "EC2 Instance Type"
    default     = "t3.micro"
}
variable "vpc_id" {
    type        = string
    description = "VPC ID"
}
variable "subnet_id" {
    type        = string
    description = "Subnet ID"
}
variable "key_pair_name" {
    type        = string
    description = "Key Pair Name"
}
variable "tags" {
    type = map
    description = "Tags"
    default     = {}
}
variable "root_device_volume_type" {
    type        = string
    description = "EC2 Root Block Device Volume Type"
    default     = "gp2"
}
variable "root_device_volume_size" {
    type        = number
    description = "EC2 Root Block Device Volume Size"
    default     = 8
}
variable "root_device_encrypted" {
    type        = bool
    description = "EC2 Root Block Device Encrypted"
    default     = true
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
variable "dns_records" {
    type        = list(any)
    description = "A list of DNS records to create with the instance's IP"
    default     = []
}