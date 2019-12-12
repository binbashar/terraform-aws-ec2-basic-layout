package tests

import (
    "testing"

    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestAwsEc2BasicLayout(t *testing.T) {
    expectedValue1  := "us-east-1a"
    expectedValue2  := "t3.micro"
    expectedValue3  := "bb-infra-deployer"
    expectedValue4  := "basic-instance-profile"
    expectedValue5  := "[\n  \"ec2-basic-layout.aws.binbash.com.ar\",\n]"
    expectedValue6  := "[\n  \"ec2-basic-layout.binbash.com.ar\",\n]"

    terraformOptions := &terraform.Options {
        // The path to where our Terraform code is located
        TerraformDir: "fixture/",

        // Disable colors in Terraform commands so its easier to parse stdout/stderr
        NoColor: true,
    }

    // At the end of the test, run `terraform destroy` to clean up any resources that were created
    defer terraform.Destroy(t, terraformOptions)

    // This will run `terraform init` and `terraform apply` and fail the test if there are any errors
    terraform.InitAndApply(t, terraformOptions)

    // Run `terraform output` to get the values of output variables
    actualOutput1   := terraform.Output(t, terraformOptions, "aws_instance_az")
    actualOutput2   := terraform.Output(t, terraformOptions, "aws_instance_type")
    actualOutput3   := terraform.Output(t, terraformOptions, "aws_instance_key_name")
    actualOutput4   := terraform.Output(t, terraformOptions, "aws_instance_iam_profile")
    actualOutput5   := terraform.Output(t, terraformOptions, "dns_record_private")
    actualOutput6   := terraform.Output(t, terraformOptions, "dns_record_public")

    // Verify we're getting back the outputs we expect
    assert.Equal(t, expectedValue1, actualOutput1)
    assert.Equal(t, expectedValue2, actualOutput2)
    assert.Equal(t, expectedValue3, actualOutput3)
    assert.Equal(t, expectedValue4, actualOutput4)
    assert.Equal(t, expectedValue5, actualOutput5)
    assert.Equal(t, expectedValue6, actualOutput6)
}