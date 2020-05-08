.PHONY: help
SHELL := /bin/bash
LOCAL_OS_USER := $(shell whoami)
LOCAL_OS_SSH_DIR := ~/.ssh
LOCAL_OS_GIT_CONF_DIR := ~/.gitconfig
LOCAL_OS_AWS_CONF_DIR := ~/.aws

# localhost aws-iam-profile
#LOCAL_OS_AWS_PROFILE := bb-shared-deploymaster
# ci aws-iam-profile
LOCAL_OS_AWS_PROFILE :="bb-dev-deploymaster"
LOCAL_OS_AWS_REGION := us-east-1

TF_PWD_DIR := $(shell pwd)
TF_VER := 0.12.24
TF_PWD_CONT_DIR := "/go/src/project/"
TF_DOCKER_ENTRYPOINT := /usr/local/go/bin/terraform
TF_DOCKER_IMAGE := binbash/terraform-resources

TERRATEST_DOCKER_ENTRYPOINT := dep
TERRATEST_DOCKER_WORKDIR := /go/src/project/tests

#
# TERRAFORM
#
define TF_CMD_PREFIX
docker run --rm \
-v ${TF_PWD_DIR}:${TF_PWD_CONT_DIR}:rw \
--entrypoint=${TF_DOCKER_ENTRYPOINT} \
-w ${TF_PWD_CONT_DIR} \
-it ${TF_DOCKER_IMAGE}:${TF_VER}
endef

#
# TERRATEST
#
define TERRATEST_GO_CMD_PREFIX
docker run --rm \
-v ${TF_PWD_DIR}:${TF_PWD_CONT_DIR}:rw \
-v ${LOCAL_OS_SSH_DIR}:/root/.ssh \
-v ${LOCAL_OS_GIT_CONF_DIR}:/etc/gitconfig \
-v ${LOCAL_OS_AWS_CONF_DIR}:/root/.aws \
-w ${TERRATEST_DOCKER_WORKDIR} \
-it ${TF_DOCKER_IMAGE}:${TF_VER}
endef

define TERRATEST_DEP_CMD_PREFIX
docker run --rm \
-v ${TF_PWD_DIR}:${TF_PWD_CONT_DIR}:rw \
-v ${LOCAL_OS_SSH_DIR}:/root/.ssh \
-v ${LOCAL_OS_GIT_CONF_DIR}:/etc/gitconfig \
--entrypoint=${TERRATEST_DOCKER_ENTRYPOINT} \
-it ${TF_DOCKER_IMAGE}:${TF_VER}
endef

help:
	@echo 'Available Commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2}'

#==============================================================#
# TERRAFORM 												                           #
#==============================================================#
version: ## Show terraform version
	docker run --rm \
	--entrypoint=${TF_DOCKER_ENTRYPOINT} \
	-t ${TF_DOCKER_IMAGE}:${TF_VER} version

format: ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
	${TF_CMD_PREFIX} fmt -recursive

format-check: ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
	${TF_CMD_PREFIX} fmt -check -recursive

pre-commit: ## Execute validation: pre-commit run --all-files.
	pre-commit run --all-files

terraform-docs: ## A utility to generate documentation from Terraform 0.12 modules in various output formats.
	docker run --rm \
  	-v $$(pwd):/data \
  	cytopia/terraform-docs:0.6.0 \
  	terraform-docs-012 --sort-inputs-by-required --with-aggregate-type-defaults markdown table .

tflint: ## TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan (tf0.12 > 0.10.x).
	docker run --rm \
	-v ${LOCAL_OS_AWS_CONF_DIR}:/root/.aws \
	-v ${TF_PWD_DIR}:/data \
	-t wata727/tflint:0.13.2

tflint-deep: ## TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan (tf0.12 > 0.10.x).
	docker run --rm \
	-v ${LOCAL_OS_AWS_CONF_DIR}:/root/.aws \
	-v ${TF_PWD_DIR}:/data \
	-t wata727/tflint:0.13.2 --deep \
	--aws-profile=${LOCAL_OS_AWS_PROFILE} \
	--aws-creds-file=/root/.aws/credentials \
	--aws-region=${LOCAL_OS_AWS_REGION}

#==============================================================#
# TERRATEST 												                           #
#==============================================================#
terratest-dep-init: ## dep is a dependency management tool for Go. (https://github.com/golang/dep)
	${TERRATEST_DEP_CMD_PREFIX} init
	${TERRATEST_DEP_CMD_PREFIX} ensure
	sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} .
	cp -r ./vendor ./tests/ && rm -rf ./vendor
	cp -r ./Gopkg* ./tests/ && rm -rf ./Gopkg*

terratest-go-test: ## Run E2E terratests
	${TERRATEST_GO_CMD_PREFIX} test -timeout 20m
	sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} .

#==============================================================#
# CIRCLECI 													                           #
#==============================================================#
circleci-validate-config: ## Validate A CircleCI Config (https://circleci.com/docs/2.0/local-cli/)
	circleci config validate .circleci/config.yml
