#
# Define some input just to show how variables can be passed from the test.
#
#variable "countries" {
#    description = "Countries"
#    default     = "AR,BR,CH"
#}

#
# Instantiate the module.
#
#module "backend" {
#    source      = "../../"
#
#    countries   = "${var.countries}"
#}

#
# Output the module's output for verification.
#
#output "countries" {
#    value = "${module.sample.countries}"
#}

module "terraform-aws-basic-layout" {
  source = "../../"

  vpc_id        = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_id     = tostring(data.terraform_remote_state.vpc.outputs.public_subnets[0][0])
  key_pair_name = data.terraform_remote_state.security.outputs.aws_key_pair_name
}
