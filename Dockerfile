# builder image
FROM rust:1.38 as builder

RUN apt-get update
RUN apt-get install musl-tools -y

RUN rustup target add x86_64-unknown-linux-musl

WORKDIR /app

COPY Cargo.toml Cargo.lock ./

# Build a temp app to install 
RUN mkdir src/
RUN echo "fn main() {println!(\"docker build broke\")}" > src/main.rs
RUN RUSTFLAGS=-Clinker=musl-gcc cargo build --release --target=x86_64-unknown-linux-musl

COPY . .
RUN RUSTFLAGS=-Clinker=musl-gcc cargo install --target=x86_64-unknown-linux-musl --path .

# release image
FROM alpine:3.10

RUN addgroup -g 1001 appuser && adduser -D -s /bin/sh -u 1001 -G appuser appuser
USER appuser

WORKDIR /app
COPY --from=builder /usr/local/cargo/bin/{{project-name}} .

ENTRYPOINT [ "./{{project-name}}" ]
