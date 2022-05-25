# Change Log

All notable changes to this project will be documented in this file.

<a name="unreleased"></a>
## [Unreleased]



<a name="v0.3.31"></a>
## [v0.3.31] - 2022-05-25

- added ref link to Examples section
- changed module name in example
- corrected a typo in README
- Removed examples from main README, added new example folder for SSM and corresponding README
- added SSM description and example in README.md file


<a name="v0.3.30"></a>
## [v0.3.30] - 2022-05-24

- changed count formula and added proper managed policy


<a name="v0.3.29"></a>
## [v0.3.29] - 2022-05-23

- changed var type to bool, simplified count and added terraform docs pre-commit
- changed managed policy name
- added SSM flag for SSM policy attachment


<a name="v0.3.28"></a>
## [v0.3.28] - 2022-05-10

- Upgrade AWS provider version constraint ([#31](https://github.com/binbashar/terraform-aws-ec2-basic-layout/issues/31))


<a name="v0.3.27"></a>
## [v0.3.27] - 2021-10-29

- Replace map function which is no longer supported in Terraform v1.x ([#30](https://github.com/binbashar/terraform-aws-ec2-basic-layout/issues/30))


<a name="v0.3.26"></a>
## [v0.3.26] - 2021-10-08

- Create FUNDING.yml


<a name="v0.3.25"></a>
## [v0.3.25] - 2021-08-25

- Updating terratest expected outputs for testcase num 3
- fixing terratest expected outputs
- updating README.md based in terraform-docs exec
- unifing circleci tests
- upgrading terraform, circleci vm and awscli to python3 compatible version
- updating license


<a name="v0.3.24"></a>
## [v0.3.24] - 2021-08-13



<a name="v0.3.23"></a>
## [v0.3.23] - 2020-11-16

- BBL-440 | circleci config slack notif improvement


<a name="v0.3.22"></a>
## [v0.3.22] - 2020-11-13

- BBL-440 | circleci config slack notif updated
- BBL-440 | updating circleci slack notif


<a name="v0.3.21"></a>
## [v0.3.21] - 2020-11-13

- BBL-440 | adding circleci slack orb for notifications
- BBL-440 | re-enabling terratest
- BBL-440 | adding terraform binary for pre-commit exec
- BBL-440 | updating mv with sudo + temporally disabling terratest jobs
- BBL-440 | fixing terraform-docs installation
- BBL-440 | adding missing terraform-docs binary dep
- BBL-440 | fixing circleci/config.yml sintaxt
- BBL-440 | makefile lib ver approach added + pre-commit for ci


<a name="v0.3.20"></a>
## [v0.3.20] - 2020-10-22

- BBL-192 | fixing variable name


<a name="v0.3.19"></a>
## [v0.3.19] - 2020-10-21

- BBL-192 | updating variable description


<a name="v0.3.18"></a>
## [v0.3.18] - 2020-10-21

- BBL-192 | adding var to README.md
- BBL-192 | updating AMI tags to follow aws-config expected security workflow
- BBL-192 | make format applied
- BBL-192 | taggin ami to approve and pass aws-config approved-amis-by-tag rule


<a name="v0.3.17"></a>
## [v0.3.17] - 2020-10-02

- Merge branch 'master' of github.com:binbashar/terraform-aws-ec2-basic-layout
- BBL-381 | adding trailing space at makefile


<a name="v0.3.16"></a>
## [v0.3.16] - 2020-10-02

- BBL-381 | updating makefile include sintaxt + circleci sumologic integration


<a name="v0.3.15"></a>
## [v0.3.15] - 2020-09-24

- BBL-381 | upgrading circleci machine exec ver


<a name="v0.3.14"></a>
## [v0.3.14] - 2020-09-18

- BBL-381 | minor readme.md figures resizeing update


<a name="v0.3.13"></a>
## [v0.3.13] - 2020-09-18

- Merge branch 'master' into BBL-381-testing-ci
- BBL-381 | adding makefile must have commented lines
- BBL-381 | mirnor README.md params update
- BBL-381 | updating versions.tf + README.md + pre-commit md
- BBL-381 | updating Makefile w/ must have comments
- BBL-381 | updating pre-commit repo versions
- BBL-381 | standalone makefile approach implemented + README.md implemented


<a name="v0.3.12"></a>
## [v0.3.12] - 2020-09-02

- Update Terraform image to use the new slim image and also update test fixtures according to refactors made to Leverage DNS and Security layers ([#22](https://github.com/binbashar/terraform-aws-ec2-basic-layout/issues/22))


<a name="v0.3.11"></a>
## [v0.3.11] - 2020-08-20

- BBL-192 | updating .gitignore + adding .editorconfig + Makefile docker img ver updated


<a name="v0.3.10"></a>
## [v0.3.10] - 2020-07-21

- BBL-272 updating aws creds to shared acct profile
- BBL-272 aws provider role for tests updated to work with circleci
- BBL-272 module updated to addressed the issue [#17](https://github.com/binbashar/terraform-aws-ec2-basic-layout/issues/17)
- BBL-272 std repo structure files in place
- BBL-272 - https://github.com/binbashar/terraform-aws-ec2-basic-layout/issues/17


<a name="v0.3.9"></a>
## [v0.3.9] - 2020-05-08

- Remove associate_public_ip_address from being a factor when creating … ([#19](https://github.com/binbashar/terraform-aws-ec2-basic-layout/issues/19))


<a name="v0.3.8"></a>
## [v0.3.8] - 2020-04-07



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


[Unreleased]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.31...HEAD
[v0.3.31]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.30...v0.3.31
[v0.3.30]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.29...v0.3.30
[v0.3.29]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.28...v0.3.29
[v0.3.28]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.27...v0.3.28
[v0.3.27]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.26...v0.3.27
[v0.3.26]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.25...v0.3.26
[v0.3.25]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.24...v0.3.25
[v0.3.24]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.23...v0.3.24
[v0.3.23]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.22...v0.3.23
[v0.3.22]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.21...v0.3.22
[v0.3.21]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.20...v0.3.21
[v0.3.20]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.19...v0.3.20
[v0.3.19]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.18...v0.3.19
[v0.3.18]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.17...v0.3.18
[v0.3.17]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.16...v0.3.17
[v0.3.16]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.15...v0.3.16
[v0.3.15]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.14...v0.3.15
[v0.3.14]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.13...v0.3.14
[v0.3.13]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.12...v0.3.13
[v0.3.12]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.11...v0.3.12
[v0.3.11]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.10...v0.3.11
[v0.3.10]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.9...v0.3.10
[v0.3.9]: https://github.com/binbashar/terraform-aws-ec2-basic-layout/compare/v0.3.8...v0.3.9
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
