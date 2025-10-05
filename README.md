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
This library requires **monero-rust** located at `../monero-rust` relative to this project.

**Important**: `monero-rust` uses monero-oxide as a git submodule. After cloning
`monero-rust`, you must initialize its submodules:

```bash
cd ../monero-rust
git submodule update --init --recursive
```

Directory structure:
```
parent-dir/
├── monero-dart/                (this project)
└── monero-rust/                (required, with submodules initialized)
    └── vendored/
        └── monero-oxide/       (git submodule)
```

### Quick start
```bash
git clone git@github.com:ManyMath/monero-dart
git clone git@github.com:ManyMath/monero-rust
cd monero-rust
git submodule update --init --recursive
cd ../monero-dart/example
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
