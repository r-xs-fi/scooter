# syntax=docker/dockerfile:1

FROM --platform=linux/amd64 rust:latest AS builder

# not usable in RUN commands unless declared first
ARG TARGETPLATFORM

RUN <<EOF
set -eu

# need to remap Dockerfile target platform to Rust's <arch>-<os>-<abi> triplets
# some arches using glibc because https://github.com/rust-lang/rust/issues/82519
case "$TARGETPLATFORM" in \
  "linux/amd64") target="x86_64-unknown-linux-musl" ;; \
  "linux/arm64") target="aarch64-unknown-linux-gnu" ;; \
  "linux/arm/v7") target="riscv64gc-unknown-linux-musl" ;; \
  "linux/riscv64") target="riscv64gc-unknown-linux-musl" ;; \
  *) echo "Unsupported TARGETPLATFORM $TARGETPLATFORM" && exit 1 ;; \
esac

rustup target add "$target"

cargo install --target="$target" scooter
EOF

FROM alpine:latest

WORKDIR /workspace

ENTRYPOINT ["/usr/bin/scooter"]

# running as unprivileged user not possible because: needs to be able to preserve file ownership
# USER 1000:1000

COPY --from=builder /usr/local/cargo/bin/scooter /usr/bin/scooter

