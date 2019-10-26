resource "aws_instance" "main" {
    ami                     = var.ami_id
    instance_type           = var.instance_type
    vpc_security_group_ids  = [ aws_security_group.main.id ]
    subnet_id               = var.subnet_id
    key_name                = var.key_pair_name
    iam_instance_profile    = var.instance_profile
    ebs_optimized           = var.ebs_optimized
    
    root_block_device {
        volume_type = var.root_device_volume_type
        volume_size = var.root_device_volume_size
        encrypted   = var.root_device_encrypted
    }
    
    tags = var.tags
}