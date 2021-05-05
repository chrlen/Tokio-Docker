This repository provides a template for a service utilizing the Rust programming language and the [Tokio platform](https://github.com/tokio-rs/tokio).
The templates includes a Dockerfile for building a small Docker image based on Alpine linux and a docker-compose file to deploy the container while adding a route to Traefik.

# Setup
Install the [Rustup](https://rustup.rs/) toolchain manager according to the instructions for your platform.
Then run the following commands to install a nightly Rust toolchain and build a release binary.
```
rustup install nightly
cargo +nightly build --release
```

## Docker

Run the following line to build an image from the Dockerfile.
```
docker build .
```

## NixOS
If you are on NixOS you can use the provided shell.nix.

```
nix-shell
```

