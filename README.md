# `monero`
This is a library for using Monero in Dart.  It uses `monero-rust`, whose cargo
build is integrated into the Dart build process by
[cargokit](https://github.com/irondash/cargokit).

## Setup
### Dependencies

#### Version Requirements
- **Dart SDK**: ^3.10.0-162.1.beta
- **Flutter**: >=3.3.0 (tested with 3.37.0-0.1.pre beta)
- **Rust**: 1.75+ (tested with 1.90.0)

#### Repository Dependencies
This library requires the following sibling repositories for building:

1. **monero-rust** - Must be located at `../monero-rust` relative to this project.
2. **serai-mirror** - Must be located at `../serai-mirror` relative to this project.
   - **Important for Android builds**: Must be on the `fix/android-serai` branch.
   - This branch contains a patch to use rustls-tls instead of native-tls for Android compatibility.
   - The Rust build uses a `[replace]` directive to substitute the published monero-serai-mirror with this local version.

Directory structure:
```
parent-dir/
├── monero-dart-cargokit/       (this project)
├── monero-rust/                (required)
└── serai-mirror/               (required, branch: fix/android-serai)
```

### Quick start
```
git clone git@github.com:ManyMath/monero-dart
git clone git@github.com:ManyMath/monero-rust
git clone -b fix/android-serai git@github.com:ManyMath/serai-mirror
cd monero-dart/example
flutter pub get
flutter run -d <device>
```

## Development
- To generate `monero-rust_bindings_generated.dart` Dart bindings for C:
  ```
  dart run ffigen --config ffigen.yaml
  ```
- If bindings are generated for a new (not previously supported/included in 
  `lib/monero_base.dart`) function, a wrapper must be written for it by hand 
  (see: `generateMnemonic`, `generateAddress`).
