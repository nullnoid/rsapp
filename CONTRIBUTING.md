# Contributing

## Setup Developement Environment

### General Tools

#### pre-commit

[pre-commit](https://pre-commit.com/) is a framework for managing and maintaining multi-language pre-commit hooks.

```bash
brew install pre-commit
```

Install the git hooks after git clone the repo.

```bash
pre-commit install
```

#### VSCode extension

- [Better TOML](vscode:extension/bungcip.better-toml)
- [Rust (rls)](vscode:extension/rust-lang.rust)
- [CodeLLDB](vscode:extension/vadimcn.vscode-lldb)

### Setting up Rust via Rustup

Install [Rustup](https://rustup.rs/) and Rust source and documentions.

```bash
curl https://sh.rustup.rs -sSf | sh
rustup component add rust-src
rustup component add rust-docs
rustup update
```

Also, we can installl Rust's nightly version alongside statble.

```bash
rustup toolchain install nightly
```

To change the toolchain at project level, run:

```bash
rustup override set nightly
```

### Tools

#### [cargo-edit](https://github.com/killercup/cargo-edit)

A utility for managing cargo dependencies from the command line.

```bash
cargo install cargo-edit
```

#### [cargo-generate](https://github.com/ashleygwilliams/cargo-generate)

cargo, make me a project

```bash
cargo install cargo-generate
```

#### rust-clippy

[Clippy](https://github.com/rust-lang/rust-clippy) is a collection of lints to catch common mistakes and improve your Rust code.

```bash
rustup component add clippy
```

#### rustfmt

[rustfmt](https://github.com/rust-lang/rustfmt) is a tool for formatting Rust code according to style guidelines.

```bash
rustup component add rustfmt
```
