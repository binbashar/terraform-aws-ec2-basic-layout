#
# Security Groups
#
resource "aws_security_group" "main" {
  count       = length(var.security_group_rules) > 0 ? 1 : 0
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
  security_group_id = aws_security_group.main[0].id
}

#
# Security Groups Egress Rules
#
resource "aws_security_group_rule" "egress_allow_all" {
  count             = length(var.security_group_rules) > 0 ? 1 : 0
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow Egress All"
  security_group_id = aws_security_group.main[0].id
}

#
# EC2 Profile (IAM Role)
#
resource "aws_iam_instance_profile" "basic_instance" {
  count = var.instance_profile == "" ? 1 : 0

  name = "${var.prefix}-${var.name}"
  role = aws_iam_role.basic_instance_assume_role[0].name
}

resource "aws_iam_role" "basic_instance_assume_role" {
  count = var.instance_profile == "" ? 1 : 0

  name               = "${var.prefix}-${var.name}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

#
# Attach a list of AWS IAM Managed Policies
#
resource "aws_iam_role_policy_attachment" "this" {
  count = var.instance_profile == "" && length(var.policy_arn) > 0 ? length(var.policy_arn) : 0

  role       = aws_iam_role.basic_instance_assume_role[0].name
  policy_arn = var.policy_arn[count.index]
}

#
# AWS cross-acocunt services by assumable role
# Create and attach AWS IAM customer managed policies
#
resource "aws_iam_role_policy_attachment" "basic_instance_aws_roles" {
  count = var.instance_profile == "" && length(var.cross_account_roles_resource_arn_list) > 0 ? 1 : 0

  role       = aws_iam_role.basic_instance_assume_role[0].name
  policy_arn = aws_iam_policy.cross_org_instance_access[0].arn
}

resource "aws_iam_policy" "cross_org_instance_access" {
  count = var.instance_profile == "" && length(var.cross_account_roles_resource_arn_list) > 0 ? 1 : 0

  name        = "cross-org-instance-policy"
  description = "Access policy for basic_instance"
  policy      = data.aws_iam_policy_document.cross_org_instance_access.json
}

data "aws_iam_policy_document" "cross_org_instance_access" {
  policy_id = "instanceCrossAccountPolicyID"

  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    resources = [
      for resource_arn in var.cross_account_roles_resource_arn_list :
      resource_arn
    ]

    sid = "ec2AssumeRoleCrossAccountStatementID"
  }
}

# SSM Policy
# Attach the AmazonSSMManagedInstanceCore policy to the instance role
# If instance_role is not provided, attach the policy to the basic_instance role
resource "aws_iam_role_policy_attachment" "ec2_ssm_access" {
  count      = var.enable_ssm_access == true ? 1 : 0
  role       = var.instance_profile == "" ? aws_iam_role.basic_instance_assume_role[0].name : var.instance_profile
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
