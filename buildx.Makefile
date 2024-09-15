#!/usr/bin/make

# Makefile for building multi-arch images for nginx-unit and pushing them to docker hub
# Make sure you have docker buildx installed and enabled
# https://docs.docker.com/build/building/multi-platform/
# Specifically that you have setup a multi-arch builder, and that you have set the default builder to it
# ex: docker buildx create --name mybuilder --driver docker-container --bootstrap --use
#
# examples: 
#	make buildx-python3.11 PLATFORMS=linux/amd64,linux/arm64 DOCKER_REPO=yourname/nginx-unit -f buildx.Makefile
#	make buildx-python3.11 PLATFORMS=linux/amd64,linux/arm64 DOCKER_REPO=yourname/nginx-unit VARIANT=slim TAG_SUFFIX=-slim -f buildx.Makefile
#   make buildx-python3.11 PLATFORMS=linux/amd64,linux/amd64/v2,linux/amd64/v3,linux/arm64,linux/ppc64le,linux/s390x,linux/386,linux/arm/v7,linux/arm/v6 DOCKER_REPO=yourname/nginx-unit VARIANT=slim TAG_SUFFIX=-slim BUILD_OPTIONS= -f buildx.Makefile
# 	make buildxall DOCKER_REPO=yourname/nginx-unit -f buildx.Makefile
#   make buildxall PLATFORMS=linux/arm64 DOCKER_REPO=yourname/nginx-unit -f buildx.Makefile
# authors: 0x6f677548

# docker hub repository (use your personal docker hub repo here) (ex: DOCKER_REPO=yourname/nginx-unit)
DOCKER_REPO ?=
# docker tag suffix (ex: "-slim"). This is appended to the tag. Useful for building variants like "slim"
TAG_SUFFIX ?=

# build options (ex: --no-cache)
BUILD_OPTIONS ?= --no-cache

include Makefile


# platform to build for (ex: PLATFORMS=linux/amd64,linux/arm64,linux/arm/v7)
# usually, docker installs a builder able to build for the following platforms:
# linux/amd64,linux/amd64/v2,linux/amd64/v3,linux/arm64,linux/ppc64le,linux/s390x,linux/386,linux/arm/v7,linux/arm/v6
# although, not all modules are available for all platforms
PLATFORMS ?= linux/amd64,linux/amd64/v2,linux/amd64/v3,linux/arm64,linux/ppc64le,linux/arm/v7


# Function to generate targets for a module and its versions
define module_versions
$(foreach ver,$(VERSIONS_$(1)),buildx-$(1)$(ver))
endef

# builds all modules
buildxall: $(foreach mod,$(MODULES),$(call module_versions,$(mod)))

# builds a specific module, ex: make buildx-python
buildx-%: Dockerfile.%

ifeq ($(DOCKER_REPO),)
	$(error DOCKER_REPO is not set. Please set it to your docker hub repository. Ex: DOCKER_REPO=yourname/nginx-unit)
endif
	@echo "Building $(DOCKER_REPO):$(VERSION)-$*$(VERSION_$*)$(TAG_SUFFIX) for $(PLATFORMS)"
	docker buildx build $(BUILD_OPTIONS) --platform $(PLATFORMS) -t $(DOCKER_REPO):$(VERSION)-$*$(TAG_SUFFIX) -f Dockerfile.$* --push .
