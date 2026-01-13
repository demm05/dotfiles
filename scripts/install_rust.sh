#!/bin/zsh

export RUSTUP_HOME="/sgoinfre/students/$USER/pkg/rustup"
export CARGO_HOME="/sgoinfre/students/$USER/pkg/cargo"

mkdir -p "$RUSTUP_HOME" "$CARGO_HOME"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
