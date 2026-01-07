# monero (monero-dart)
Monero in Flutter.

## Getting started

### [Install rust](https://www.rust-lang.org/tools/install)
Use `rustup`, not `homebrew`.  Install toolchain 1.85.1.

### Install cargo ndk
```sh
cargo install cargo-ndk
```

### Example app
`flutter run` in `example` to run the example app

See `example/lib/main.dart` for usage.

## Development

### Project structure
This plugin uses the following structure:

* `rust`: Contains the Rust native source code and Cargo.toml manifest for building
  the native library.
* `cargokit`: Cross-platform build tool that compiles Rust code for all target platforms
  (Android NDK, iOS/macOS, Linux, Windows).
* `lib`: Contains the Dart code that defines the API of the plugin, and which
  calls into the native code using `dart:ffi`.
* platform folders (`android`, `ios`, `windows`, etc.): Contains the build files
  that invoke Cargokit to build and bundle the Rust library with the platform application.

### Invoking native code
Very short-running native functions can be directly invoked from any isolate.
For example, see `sum` in `lib/monero.dart`.

Longer-running functions should be invoked on a helper isolate to avoid
dropping frames in Flutter applications.
For example, see `sumAsync` in `lib/monero.dart`.

### Cargokit
[Cargokit](https://github.com/ManyMath/cargokit) handles building, just `flutter run` it or run it as you normally would on your platform.

To update Cargokit in the future, use:
```sh
git subtree pull --prefix cargokit https://github.com/ManyMath/cargokit.git main --squash
```

### Bindings generation
* `cargo build` in `rust/` triggers `build.rs` to generate `monero_ffi.h` C headers.
* To generate `monero_ffi.g.dart` Dart bindings: `dart run tool/ffigen.dart` in
  the root (may require LLVM, see `ffigen`'s documentation.)
