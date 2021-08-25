package tests

import (
    "testing"

    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

//
// E2E Terratest Case1: ec2-default-instance-profile
//
func TestAwsEc2BasicLayoutCase1(t *testing.T) {
    expectedValue1  := "us-east-1a"
    expectedValue2  := "t3.micro"
    expectedValue3  := "bb-infra-deployer"
    expectedValue4  := "basic-instance-profile-infra-ec2-test"
    expectedValue5  := "basic-instance-role-infra-ec2-test"
    expectedValue6  := "[ec2-basic-layout.aws.binbash.com.ar]"
    expectedValue7  := "[ec2-basic-layout.binbash.com.ar]"

    terraformOptions := &terraform.Options {
        // The path to where our Terraform code is located
        TerraformDir: "../examples/ec2-default-instance-profile",

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
    actualOutput5   := terraform.Output(t, terraformOptions, "aws_instance_assume_role_name")
    actualOutput6   := terraform.Output(t, terraformOptions, "dns_record_private")
    actualOutput7   := terraform.Output(t, terraformOptions, "dns_record_public")

    // Verify we're getting back the outputs we expect
    assert.Equal(t, expectedValue1, actualOutput1)
    assert.Equal(t, expectedValue2, actualOutput2)
    assert.Equal(t, expectedValue3, actualOutput3)
    assert.Contains(t, actualOutput4, expectedValue4)
    assert.Contains(t, actualOutput5, expectedValue5)
    assert.Equal(t, expectedValue6, actualOutput6)
    assert.Equal(t, expectedValue7, actualOutput7)
}

//
// E2E Terratest Case2: ec2-default-instance-profile-simple
//
func TestAwsEc2BasicLayoutCase2(t *testing.T) {
    expectedValue1  := "us-east-1a"
    expectedValue2  := "t3.micro"
    expectedValue3  := "bb-infra-deployer"
    expectedValue4  := "basic-instance-profile-default-ec2-test"
    expectedValue5  := "basic-instance-role-default-ec2-test"
    expectedValue6  := "[]"
    expectedValue7  := "[]"

    terraformOptions := &terraform.Options {
        // The path to where our Terraform code is located
        TerraformDir: "../examples/ec2-default-instance-profile-simple",

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
    actualOutput5   := terraform.Output(t, terraformOptions, "aws_instance_assume_role_name")
    actualOutput6   := terraform.Output(t, terraformOptions, "dns_record_private")
    actualOutput7   := terraform.Output(t, terraformOptions, "dns_record_public")

    // Verify we're getting back the outputs we expect
    assert.Equal(t, expectedValue1, actualOutput1)
    assert.Equal(t, expectedValue2, actualOutput2)
    assert.Equal(t, expectedValue3, actualOutput3)
    assert.Contains(t, actualOutput4, expectedValue4)
    assert.Contains(t, actualOutput5, expectedValue5)
    assert.Equal(t, expectedValue6, actualOutput6)
    assert.Equal(t, expectedValue7, actualOutput7)
}

//
// E2E Terratest Case3: ec2-external-instance-profile
//
func TestAwsEc2BasicLayoutCase3(t *testing.T) {
    expectedValue1  := "us-east-1a"
    expectedValue2  := "t3.micro"
    expectedValue3  := "bb-infra-deployer"
    expectedValue4  := "basic-instance-profile-external"
    expectedValue5  := ""
    expectedValue6  := "[ec2-basic-layout.aws.binbash.com.ar]"
    expectedValue7  := "[ec2-basic-layout.binbash.com.ar]"

    terraformOptions := &terraform.Options {
        // The path to where our Terraform code is located
        TerraformDir: "../examples/ec2-external-instance-profile",

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
    actualOutput5   := terraform.Output(t, terraformOptions, "aws_instance_assume_role_name")
    actualOutput6   := terraform.Output(t, terraformOptions, "dns_record_private")
    actualOutput7   := terraform.Output(t, terraformOptions, "dns_record_public")

    // Verify we're getting back the outputs we expect
    assert.Equal(t, expectedValue1, actualOutput1)
    assert.Equal(t, expectedValue2, actualOutput2)
    assert.Equal(t, expectedValue3, actualOutput3)
    assert.Equal(t, expectedValue4, actualOutput4)
    assert.Equal(t, expectedValue5, actualOutput5)
    assert.Equal(t, expectedValue6, actualOutput6)
    assert.Equal(t, expectedValue7, actualOutput7)
}
