RUST_SYSROOT := $(shell rustc --print sysroot)

.PHONY: all clean

all: main-c main-objc main-swift main-rs main-ts

clean:
	@rm -f main-c
	@rm -f main-objc
	@rm -f main-swift
	@rm -f main-rs
	@rm -f .*.bun-build main-ts

main-c:
	@clang -o main-c main.c
	@./main-c

main-objc:
	@clang -o main-objc main.m -framework Foundation
	@./main-objc

main-swift:
	@swiftc -o main-swift main.swift
	@./main-swift

# Dynamically link the Rust std library to minimize file size,
# since the C, ObjC, and Swift std libraries are dynamically linked by default.
main-rs:
	@rustc -o main-rs main.rs \
		-C prefer-dynamic \
		-C link-arg=-Wl,-rpath,$(RUST_SYSROOT)/lib/rustlib/aarch64-apple-darwin/lib
	@./main-rs

main-ts:
	@bun build --compile --outfile main-ts main.ts
	@./main-ts
