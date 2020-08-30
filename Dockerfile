FROM rust:latest as cargo-build

RUN rustup default nightly
RUN rustup target add x86_64-unknown-linux-musl
RUN rustup install nightly
WORKDIR /usr/src/rust_rest
COPY . .
RUN cargo +nightly build --target=x86_64-unknown-linux-musl --release

FROM alpine:latest

RUN addgroup -g 1000 rust_rest
RUN adduser -D -s /bin/sh -u 1000 -G rust_rest rust_rest
WORKDIR /home/rust_rest/bin/
COPY --from=cargo-build /usr/src/rust_rest/target/x86_64-unknown-linux-musl/release/server .
RUN chown rust_rest:rust_rest server
USER rust_rest
CMD [ "./server" ]