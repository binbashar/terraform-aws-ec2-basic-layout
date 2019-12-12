//
// AWS EC2 profile w/ IAM Role association
//
resource "aws_iam_instance_profile" "basic_instance" {
  name = "basic-instance-profile"
  role = aws_iam_role.basic_instance_assume_role.name
}

resource "aws_iam_role" "basic_instance_assume_role" {
  name = "basic-instance-role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

//
// This policy applies in the custom scenario where you have an AWS multi-account org setup with 3 accounts and 2 roles,
// as can already thought this is a very specific layout and not much probable to be actually your current setup
// so please consider using the output "aws_iam_ec2_profile_role_arn" to create your custom aws_iam_policy
// and attach it (aws_iam_role_policy_attachment).
//
resource "aws_iam_policy" "basic_instance_access" {
  name        = "basic-instance-policy"
  description = "Access policy for basic_instance"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ecr:*",
                "ssm:*",
                "route53:*",
                "s3:ListBucket",
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "basic_instance_aws_services_and_roles" {
  role       = aws_iam_role.basic_instance_assume_role.name
  policy_arn = aws_iam_policy.basic_instance_access.arn
}
