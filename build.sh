#!/bin/sh
rustup target add armv7-unknown-linux-musleabihf
cargo build --release --target=armv7-unknown-linux-musleabihf
