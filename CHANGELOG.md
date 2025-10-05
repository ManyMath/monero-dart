## 0.0.6

- Migrated from native_toolchain_rust to cargokit for Android/iOS support.
- Fixed Android build: resolved OpenSSL dependency issue by using rustls-tls in monero-serai-mirror.
- Added Cargo [replace] directive to use local serai-mirror with Android-compatible TLS backend.
- Requires serai-mirror at `../serai-mirror` with `fix/android-serai` branch for Android builds.

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
