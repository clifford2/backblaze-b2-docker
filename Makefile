# SPDX-FileCopyrightText: © 2019 Clifford Weinmann <https://www.cliffordweinmann.com/>
# SPDX-License-Identifier: Unlicense

# Use podman or docker?
ifeq ($(shell command -v podman 2> /dev/null),)
	CONTAINER_ENGINE := docker
else
	CONTAINER_ENGINE := podman
endif

# Configure build commands
ifeq ($(CONTAINER_ENGINE),podman)
	BUILDARCH := $(shell podman version --format '{{.Client.OsArch}}' | cut -d/ -f2)
	BUILD_NOLOAD := podman build
	BUILD_CMD := $(BUILD_NOLOAD)
else
	BUILDARCH := $(shell docker version --format '{{.Client.Arch}}')
	BUILD_NOLOAD := docker buildx build
	BUILD_CMD := $(BUILD_NOLOAD) --load
endif
# Get current versions
B2CLI_VERSION := $(shell bash ./build/getenv B2CLI_VERSION)
RELEASE_VERSION := $(shell bash ./build/getenv RELEASE_VERSION)
IMAGE_NAME := $(shell bash ./build/getenv IMAGE_NAME)
IMAGE_TAG := $(shell bash ./build/getenv IMAGE_TAG)
IMGRELNAME := $(shell bash ./build/getenv IMGRELNAME)

.PHONY: hello
hello:
	@echo "There is no default target for $(IMAGE_NAME):$(IMAGE_TAG) yet - please pick a suitable target manually"
	@echo "B2CLI_VERSION: [$(B2CLI_VERSION)] RELEASE_VERSION: [$(RELEASE_VERSION)]"
	@echo "We're using $(CONTAINER_ENGINE) on $(BUILDARCH)"

# After any changing .env, fix the image tags in other files
.PHONY: update-check
update-check:
	@echo 'Checking for updates'
	@build/update.sh

.PHONY: build
build: .check-depends
	$(BUILD_CMD) --pull -t $(IMAGE_NAME):$(IMAGE_TAG) .
	$(CONTAINER_ENGINE) tag $(IMAGE_NAME):$(IMAGE_TAG) $(IMAGE_NAME):latest

.PHONY: test
test: build
	$(CONTAINER_ENGINE) run --rm -it $(IMAGE_NAME):$(IMAGE_TAG) version

.PHONY: tag-image
tag-image: .check-depends
	test ! -z "$(IMGRELNAME)" || (echo "Please specify IMGRELNAME" && false)
	$(CONTAINER_ENGINE) tag $(IMAGE_NAME):$(IMAGE_TAG) $(IMGRELNAME):$(IMAGE_TAG)
	$(CONTAINER_ENGINE) tag $(IMAGE_NAME):$(IMAGE_TAG) $(IMGRELNAME):latest

.PHONY: push-image
push-image: .check-depends tag-image
	test ! -z "$(IMGRELNAME)" || (echo "Please specify IMGRELNAME" && false)
	test ! -z "$(REGISTRY_NAME)" && $(CONTAINER_ENGINE) login -u $(REGISTRY_USER) $(REGISTRY_NAME) || echo 'Not logging into registry'
	$(CONTAINER_ENGINE) push $(IMGRELNAME):$(IMAGE_TAG)
	$(CONTAINER_ENGINE) push $(IMGRELNAME):latest

.PHONY: git-commit-tag-push
git-commit-tag-push:
	@git add .
	@git commit
	@git tag -m "Version $(B2CLI_VERSION) release $(RELEASE_VERSION)" "$(IMAGE_TAG)"
	@git push --follow-tags

# Verify that we have all required dependencies installed
.PHONY: .check-depends
.check-depends:
	command -v podman || command -v docker
