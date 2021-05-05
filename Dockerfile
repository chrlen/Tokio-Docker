FROM rust:latest as cargo-build

RUN rustup default nightly
RUN rustup target add x86_64-unknown-linux-musl
RUN rustup install nightly
WORKDIR /usr/src/tokio-docker
COPY . .
RUN cargo +nightly build --target=x86_64-unknown-linux-musl --release

FROM alpine:latest

RUN addgroup -g 1000 tokio-docker
RUN adduser -D -s /bin/sh -u 1000 -G tokio-docker tokio-docker
WORKDIR /home/rust_rest/bin/
COPY --from=cargo-build /usr/src/tokio-docker/target/x86_64-unknown-linux-musl/release/tokio-docker .
RUN chown tokio-docker:tokio-docker server
USER tokio-docker
CMD [ "./server" ]