⚠️ **ARCHIVED**: nginx-unit by NGINX has been officially discontinued and archived since October 2025. This repository is no longer maintained and is being kept for reference only.

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
   git clone https://go.hugobatista.com/gh/nginx-unit-buildx.git
   cd nginx-unit-buildx
   ```

3. Build an image (use Python 3.12 or 3.13, as Python 3.11 is no longer supported):
   ```bash
   make buildx-python3.12 PLATFORMS=linux/amd64,linux/arm64 DOCKER_REPO=yourname/nginx-unit
   ```

> **Note**: Due to the project being archived, Python 3.11 is no longer available. Use Python 3.12 or 3.13 instead. You can check the available versions by looking at the `VERSIONS_python` variable in the original nginx-unit repository's Makefile.

### Building All Modules

To build images for all defined modules and their versions:

```bash
make buildxall PLATFORMS=linux/amd64 DOCKER_REPO=yourname/nginx-unit
```

### Additional Options

- **TAG_SUFFIX**: Add a suffix to the Docker tag (e.g., `-slim`).
- **BUILD_OPTIONS**: Pass additional options to Docker build (e.g., `--no-cache`).
- **VARIANT**: Specify a variant of the image (e.g., `slim`).


## Troubleshooting

### "FROM requires either one or three arguments" Error

If you encounter this error when building, it's likely because you're trying to build a module version that is no longer supported in the archived nginx-unit repository. 

This tool relies on the upstream nginx-unit repository's Makefile to define which versions are available. Since the project is archived, only specific versions are available:

- **Python**: 3.12, 3.13 (also supports slim variants)
- **Node**: 20, 22
- **PHP**: 8.3, 8.4
- **Go**: 1.24, 1.25
- **Ruby**: 3.2, 3.3
- **Perl**: 5.38, 5.40
- **JSC**: 11

Try using one of these supported versions instead.

### "exec format error" or Cross-Platform Build Failures

Since the nginx-unit project has been archived, there may be compatibility issues with cross-platform builds (e.g., building for `linux/arm64` on an `linux/amd64` host). This is a known limitation of the upstream archived repository.

If you encounter build failures on specific architectures:
- Try building for a single architecture at a time: `make buildx-python3.12 PLATFORMS=linux/amd64 DOCKER_REPO=yourname/nginx-unit`
- Consider using pre-built images or exploring alternative application servers that are actively maintained

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
