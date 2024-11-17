FROM rust:latest AS builder

RUN rustup target add x86_64-unknown-linux-musl

RUN cargo install --target=x86_64-unknown-linux-musl scooter

RUN which scooter

FROM alpine:latest

WORKDIR /workspace

ENTRYPOINT ["/usr/bin/scooter"]

# running as unprivileged user not possible because: needs to be able to preserve file ownership
# USER 1000:1000

COPY --from=builder /usr/local/cargo/bin/scooter /usr/bin/scooter

