# Change Log

All notable changes to this project will be documented in this file.

<a name="unreleased"></a>
## [Unreleased]



<a name="v0.3.8"></a>
## [v0.3.8] - 0001-01-01



<a name="v0.3.7"></a>
## [v0.3.7] - 2020-04-07

- BBL-226 fixing figures urls in README.md


<a name="v0.3.6"></a>
## [v0.3.6] - 2020-04-07

- BBL-226 introducing dummy change for CI retry.
- BBL-226 output description corrected
- BBL-226 Makefiles fmt improved
- BBL-226 adding .github dir w/ ISSUES and PRs templates
- BBL-226 README.md release mgmt section updated
- BBL-226 .chglog, .circleci and .gitignore minor improvements


<a name="v0.3.5"></a>
## [v0.3.5] - 2020-02-03

- BBL-181 reviewing ci release error
- BBL-181 examples updated to cover new module behaviour
- BBL-181 adding pre-commit run command into Makefile
- BBL-181 module update, adding new aws_instance variables support + custom role generation naming enhancement + name var changed to required.
- BBL-181 updating to latest tf-0.12.20 + minor comments and updates


<a name="v0.3.4"></a>
## [v0.3.4] - 2020-01-09

- BBL-167 clearing not necessary extra // in comment


<a name="v0.3.3"></a>
## [v0.3.3] - 2020-01-09

- BBL-167 updating role name to be in sync with CircleCI ENV var.
- BBL-167 code updated with tests
- BBL-167 updating .gitigonre to avoid pushing dynamically generated terratests files
- BBL-167 terraform fmt -check validation sintaxt simplfied
- BBL-167 Segregating Makefiles for std release-mgmt tasks


<a name="v0.3.2"></a>
## [v0.3.2] - 2019-12-20

- BBL-42 fixing readme.md image


<a name="v0.3.1"></a>
## [v0.3.1] - 2019-12-20

- BBL-42 uncommenting terratest e2e tests for final testing round
- BBL-42 updating circleci tflint-deep simplifying validation chec
- BBL-42 updating circleci tflint-deep condition update
- BBL-42 updating circleci tflint-deep condition update
- BBL-42 updating circleci tflint-deep with aws cred step
- BBL-42 updating circleci tflint-deep with aws cred step
- BBL-42 updating circleci tflint-deep with extra debugging validations
- BBL-42 updating circleci tflint-deep with temp debugging output
- BBL-42 updating circleci tflint-deep with temp debugging output
- BBL-42 updating circleci tflint-deep check condition
- BBL-42 explicitly passing /bin/bash shell to jobs
- BBL-42 explicitly passing /bin/bash shell to jobs
- BBL-42 updating circleci tflint-deep check step + temporaly disabling e2e tests
- BBL-42 updating circleci tflint-deep check step
- BBL-42 updating circleci tflint-deep step with latest version + fixed check
- BBL-42 fixing circleci config with proper AWS account info + examples README.md update
- BBL-42 uncommenting circleci test workflow in config file
- BBL-42 fixing README.md figures link
- BBL-42 fixing README.md figures link
- BBL-42 adding changelog for release-mgmt proc
- BBL-42 updating ec2 name default value
- Set theme jekyll-theme-slate


<a name="v0.3.0"></a>
## [v0.3.0] - 2019-12-17

- BBL-42 terratests added with 3 test cases from examples
- BBL-42 examples added to be also used as test sources
- BBL-42 module tf instance, security, dns updates with proper var and outupts
- BBL-42 improving markdown line length in READMEs
- BBL-42 updating aux files: Makefile, README.md and circleci/config.yml
- BBL-42 README.md updated with new input params
- BBL-42 dns, instance, network and sec module updates
- BBL-42 Adding terratests covering new module features
- BBL-42 module std structure and file updates
- customizable dns record via var


<a name="v0.2.1"></a>
## [v0.2.1] - 2019-10-26

- Add EBS Optimized option. ([#2](https://github.com/binbashar/terraform-aws-ec2-basic-layout/issues/2))


<a name="v0.2.0"></a>
## [v0.2.0] - 2019-09-13

- Add support to specify an instance profile. ([#1](https://github.com/binbashar/terraform-aws-ec2-basic-layout/issues/1))


<a name="v0.1.0"></a>
## v0.1.0 - 2019-09-11

- Initial commit
- Initial commit


[Unreleased]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.8...HEAD
[v0.3.8]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.7...v0.3.8
[v0.3.7]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.6...v0.3.7
[v0.3.6]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.5...v0.3.6
[v0.3.5]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.4...v0.3.5
[v0.3.4]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.3...v0.3.4
[v0.3.3]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.2...v0.3.3
[v0.3.2]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.1...v0.3.2
[v0.3.1]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.0...v0.3.1
[v0.3.0]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.2.1...v0.3.0
[v0.2.1]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.2.0...v0.2.1
[v0.2.0]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.1.0...v0.2.0
