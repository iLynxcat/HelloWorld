RUST_SYSROOT := $(shell rustc --print sysroot)

.PHONY: all clean

all: main-rs main-swift main-c main-objc

clean:
	@rm -f main-swift
	@rm -f main-rs
	@rm -f main-c
	@rm -f main-objc

main-objc:
	@clang -o main-objc main.m -framework Foundation
	@./main-objc

main-c:
	@clang -o main-c main.c
	@./main-c

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
