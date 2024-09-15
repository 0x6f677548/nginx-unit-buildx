#!/usr/bin/make

# This Makefile is designed to:
# 1. Clone the nginx-unit repository to a temporary folder.
# 1. Copy the buildx.Makefile to the temporary folder.
# 2. Execute the copied Makefile with the same arguments provided to this Makefile.
#
# Usage:
#   make [arguments]
#
# Example:
#   make buildx-python3.11 PLATFORMS=linux/amd64,linux/arm64 DOCKER_REPO=yourname/nginx-unit
#	make buildxall PLATFORMS=linux/amd64 DOCKER_REPO=yourname/nginx-unit 
# authors: 0x6f677548


# Define the source Makefile (always buildx.Makefile)
SOURCE_MAKEFILE := buildx.Makefile

# Define the temporary folder and the target folder
TEMP_FOLDER := $(shell mktemp -d)
TARGET_FOLDER := $(TEMP_FOLDER)/pkg/docker

# Default target
.PHONY: all
all: copy_and_execute

# Target to copy the Makefile and execute it
.PHONY: copy_and_execute
copy_and_execute:
	@echo "Cloning the nginx-unit repository to a temporary folder..."
	@git clone --branch branches/packaging https://github.com/nginx/unit $(TEMP_FOLDER)
	@echo "Copying the buildx.Makefile to the temporary folder..."
	@cp $(SOURCE_MAKEFILE) $(TARGET_FOLDER)/ 
	@$(MAKE) -C $(TARGET_FOLDER) -f $(SOURCE_MAKEFILE) $(MAKECMDGOALS)
	@echo "Removing the temporary folder..."
	@rm -rf $(TEMP_FOLDER)
# Pass through any other targets
.PHONY: %
%: copy_and_execute
	@true
