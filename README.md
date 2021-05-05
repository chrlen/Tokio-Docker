This repository provides a template for http service utilizing the Rust programming language and the Tokio framework.

The templates includes a Dockerfile for building a small Docker image based on Alpine linux and a docker-compose file to deploy the container while adding a route to Traefik.

Building for Alpine Linux requires a cross-compilation to the musl runtime.