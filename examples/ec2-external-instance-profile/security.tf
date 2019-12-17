#
# EC2: Instance Profile
#
resource "aws_iam_instance_profile" "basic_instance_profile" {
  name = "basic-instance-profile-external"
  role = aws_iam_role.basic_instance_assume_role.name
}

#
# Allow EC2 to Assume "basic-instance-role-external" Role
#
resource "aws_iam_role" "basic_instance_assume_role" {
  name = "basic-instance-role-external"
  path = "/"
  tags = local.tags

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
            "Sid": "AllowEC2ToAssumeRole"
        }
    ]
}
EOF
}

#
# EC2 S3 Permissions -- Please stick to Least Privilege Principle
#
resource "aws_iam_policy" "this" {
  name        = "ec2-role-policy-permissions"
  description = "EC2 S3 Permissions"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

#
# EC2 Full Access to its S3 bucket
#
resource "aws_iam_role_policy_attachment" "ec2_s3_permissions" {
  role       = aws_iam_role.basic_instance_assume_role.name
  policy_arn = aws_iam_policy.this.arn
}
#
# EC2 Read Access on ECR
#
resource "aws_iam_role_policy_attachment" "ec2_ecr_permissions" {
  role       = aws_iam_role.basic_instance_assume_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}