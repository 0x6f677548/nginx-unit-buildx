# Nginx Unit Multi-Architecture Image Builder

This repository contains a tool to build multi-architecture Docker images for [Nginx Unit](https://github.com/nginx/unit). It simplifies the process of creating and pushing images for various architectures to Docker Hub.

## Why?

The main reason for this tool is that not all architectures are supported in the [official Nginx Unit Docker images](https://hub.docker.com/_/unit/). Additionally, slim images are not available for all platforms, like Python. This tool aims to fill these gaps by allowing you to build custom multi-architecture images.


## Prerequisites

- Docker with Buildx support
- A Docker Hub account
- A multi-architecture builder set up (see [Docker's multi-platform building guide](https://docs.docker.com/build/building/multi-platform/))
- Git

## Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/0x6f677548/nginx-unit-buildx.git
   cd nginx-unit-buildx
   ```

3. Build an image:
   ```bash
   make buildx-python3.11 PLATFORMS=linux/amd64,linux/arm64 DOCKER_REPO=yourname/nginx-unit
   ```


### Building All Modules

To build images for all defined modules and their versions:

```bash
make buildxall PLATFORMS=linux/amd64 DOCKER_REPO=yourname/nginx-unit
```

### Additional Options

- **TAG_SUFFIX**: Add a suffix to the Docker tag (e.g., `-slim`).
- **BUILD_OPTIONS**: Pass additional options to Docker build (e.g., `--no-cache`).
- **VARIANT**: Specify a variant of the image (e.g., `slim`).


## Pre-built Images

Some multi-architecture images built by this tool can also be found pre-built at [https://hub.docker.com/r/0x6f677548/nginx-unit/tags](https://hub.docker.com/r/0x6f677548/nginx-unit/tags) (use at your own risk).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
