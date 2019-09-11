# Terraform Module: AWS EC2 Basic Layout

## Overview
This module could be useful if you find yourself creating a layout that includes the following resources:
* EC2 Instance
* Security group for the instance above
* DNS record with a record that points to the instance private IP

Personally I have seen the need of creating a similar set of such resources for an OpenVPN instance, for Jenkins, Spinnaker, DroneCI, and so forth.

## Roadmap
* Improve documentation
* Add optional Elastic IP support
* Add parameters to define the AMI so that the module takes care of looking that up
