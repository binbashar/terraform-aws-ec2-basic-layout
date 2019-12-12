#
# Security Groups
#
resource "aws_security_group" "main" {
  name        = "${var.prefix}-${var.name}-instance"
  description = "${title(var.name)} Security Group Rules"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

#
# Security Groups Ingress Rules
#
resource "aws_security_group_rule" "ingress_rules" {
  count = length(var.security_group_rules)

  type              = "ingress"
  from_port         = lookup(element(var.security_group_rules, count.index), "from_port", null)
  to_port           = lookup(element(var.security_group_rules, count.index), "to_port", null)
  protocol          = lookup(element(var.security_group_rules, count.index), "protocol", "tcp")
  cidr_blocks       = lookup(element(var.security_group_rules, count.index), "cidr_blocks", "0.0.0.0/0")
  description       = lookup(element(var.security_group_rules, count.index), "description", "")
  security_group_id = aws_security_group.main.id
}

#
# Security Groups Egress Rules
#
resource "aws_security_group_rule" "egress_allow_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow Egress All"
  security_group_id = aws_security_group.main.id
}