module "terraform-aws-basic-layout" {
  source = "../../"

  prefix = var.prefix
  name   = var.name

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
      cidr_blocks = [data.terraform_remote_state.vpc.outputs.vpc_cidr_block],
      description = "Allow SSH"
    },
    {
      from_port   = 8080,
      to_port     = 8082,
      protocol    = "tcp",
      cidr_blocks = ["0.0.0.0/0"],
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