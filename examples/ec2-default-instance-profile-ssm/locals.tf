locals {
  enable_ssm_access = true
  tags = {
    Name        = "infra-ec2-test"
    Terraform   = "true"
    Environment = var.environment
  }

  user_data = <<EOF
#!/bin/bash
echo "Hello Terraform! -> Installing pre-req packages"
apt-get update
apt-get install -y python-dev python-pip libffi-dev libssl-dev libxml2-dev libxslt1-dev libjpeg8-dev zlib1g-dev python-setuptools git
echo "DONE"
EOF

}