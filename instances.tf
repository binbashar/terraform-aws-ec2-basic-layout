data "aws_ami" "ubuntu_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.aws_ami_os_id]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  //https://askubuntu.com/questions/53582/how-do-i-know-what-ubuntu-ami-to-launch-on-ec2
  //  Any user can register an AMI under any name. Nothing prevents a malicious user from registering an AMI that would
  //  match the search above. So, in order to be safe, you need to verify that the owner of the ami is '099720109477'.
  owners = [var.aws_ami_os_owner] # Canonical
}

resource "aws_instance" "main" {
  ami                         = var.ami_id != "" ? var.ami_id : data.aws_ami.ubuntu_linux.id
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.main.id]
  subnet_id                   = var.subnet_id
  key_name                    = var.key_pair_name
  iam_instance_profile        = var.instance_profile == "" ? aws_iam_instance_profile.basic_instance[0].id : var.instance_profile
  ebs_optimized               = var.ebs_optimized
  monitoring                  = var.monitoring
  associate_public_ip_address = var.associate_public_ip_address
  user_data                   = var.user_data
  user_data_base64            = var.user_data_base64
  disable_api_termination     = var.disable_api_termination
  credit_specification {
    cpu_credits = var.credit_specification_cpu
  }


  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
    }
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
    }
  }

  dynamic "ephemeral_block_device" {
    for_each = var.ephemeral_block_device
    content {
      device_name  = ephemeral_block_device.value.device_name
      no_device    = lookup(ephemeral_block_device.value, "no_device", null)
      virtual_name = lookup(ephemeral_block_device.value, "virtual_name", null)
    }
  }

  volume_tags = merge(var.tags, map("Backup", var.root_device_backup_tag))
  tags        = var.tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to ami, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      ami,
    ]
  }
}

