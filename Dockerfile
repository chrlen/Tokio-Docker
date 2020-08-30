FROM rust:latest as cargo-build
# RUN apt-get update
# RUN apt-get install musl-tools -y
# RUN rustup target add x86_64-unknown-linux-musl
RUN rustup install nightly
WORKDIR /usr/src/rust_rest
# COPY Cargo.toml Cargo.toml
#RUN mkdir src/
#RUN echo "fn main() {println!(\"if you see this, the build broke\")}" > src/main.rs
#RUN cargo +nightly build --release
#RUN rm -f target/release/deps/rust_rest*
COPY . .
RUN cargo +nightly build --release

# ------------------------------------------------------------------------------
# Final Stage
# ------------------------------------------------------------------------------

FROM busybox:latest

RUN addgroup -g 1000 rust_rest

RUN adduser -D -s /bin/sh -u 1000 -G rust_rest rust_rest

WORKDIR /home/rust_rest/bin/

COPY --from=cargo-build /usr/src/rust_rest/target/release/server .

RUN chown rust_rest:rust_rest server
USER rust_rest
# CMD ["./server"]
ENTRYPOINT [ "/home/rust_rest/bin/server" ]
RUN ls ./
RUN pwd