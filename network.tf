resource "aws_eip" "this" {
  count    = var.associate_public_ip_address == true ? 1 : 0
  instance = aws_instance.main.id
  vpc      = true

  tags = var.tags
}