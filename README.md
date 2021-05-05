This repository provides a template for http service utilizing the Rust programming language and the Tokio framework.

The templates includes a Dockerfile for building a small Docker image based on Alpine linux and a docker-compose file to deploy the container while adding a route to Traefik.

Building for Alpine Linux requires a cross-compilation to the musl runtime.

# Setup
Install the Rustup toolchain manager according to the instructions for your platform.
Then run the following commands to install a nightly Rust toolchain and build a release binary.

```
rustup install nightly
rustup default nightly
cargo +nightly build --release
```

## NixOS
If you are on NixOS, use the provided shell.nix to avoid problems with using OpenSSL.

```
nix-shell
```

