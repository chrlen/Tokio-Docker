FROM rust:latest as cargo-build
# RUN apt-get update
# RUN apt-get install musl-tools -y
# RUN rustup target add x86_64-unknown-linux-musl
RUN rustup target add x86_64-unknown-linux-musl --toolchain=nightly
RUN rustup install nightly
WORKDIR /usr/src/rust_rest
# COPY Cargo.toml Cargo.toml
#RUN mkdir src/
#RUN echo "fn main() {println!(\"if you see this, the build broke\")}" > src/main.rs
#RUN cargo +nightly build --release
#RUN rm -f target/release/deps/rust_rest*
COPY . .
RUN cargo +nightly build --target=x86_64-unknown-linux-musl --release

# ------------------------------------------------------------------------------
# Final Stage
# ------------------------------------------------------------------------------

FROM scratch:latest

RUN addgroup -g 1000 rust_rest

RUN adduser -D -s /bin/sh -u 1000 -G rust_rest rust_rest

WORKDIR /home/rust_rest/bin/

COPY --from=cargo-build /usr/src/rust_rest/target/release/server .

RUN chown rust_rest:rust_rest server
USER rust_rest
# CMD ["./server"]
CMD [ "./server" ]
RUN ls ./
RUN pwd