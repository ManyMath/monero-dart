## 0.0.6

- Migrated from native_toolchain_rust to cargokit, breaking web platform access.
- Completely removed monero-serai-mirror dependency.
  - Replaced with monero-seed from https://github.com/ManyMath/monero-wallet-util.
  - Vendored as git submodule in monero-rust/vendored/monero-wallet-util.
  - No more serai-mirror directory required.
- Vendored monero-oxide as git submodule in monero-rust/vendored/monero-oxide.
  - All path dependencies now properly contained within monero-dart repository.
  - No more workspace-level dependency references.
- Removed unnecessary feature gates (serai-seed/mnemonic).
  - Mnemonic support is now unconditionally included.
  - Simplified codebase with no conditional compilation for seed functionality.
- Added missing `free_string` FFI function for proper C string memory management.
- Added `rlib` crate type to monero-rust for Rust-to-Rust dependencies.
- Fixed Language enum: `EnglishOld` → `DeprecatedEnglish`.
- Added helper function `seed_from_string()` that auto-detects mnemonic language (tries all 13 supported languages).

## 0.0.5

- Commandline interface builds Monero from source by default.

## 0.0.4

- Example fix
- native_toolchain_rust fix: remove dangling reference in build/hook.dart since 0.0.3.
- Added binary executable which helps download and verify the latest Monero release binary archive.

## 0.0.3

- native_toolchain_rust fixes: using native_toolchain_rust_mirror until its parent merges lib fixes.

## 0.0.2

- Migrated from libxmr to the new standalone monero-rust crate.

## 0.0.1

- Initial version.
- A proof of concept of building a Rust library with native_toolchain_rust for use in a Dart app.
- Uses cypherstack/libxmr's libxmr crate as the Rust library.
