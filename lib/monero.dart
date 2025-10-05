import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

import 'monero_bindings_generated.dart';

const String _libName = 'monero';

/// The dynamic library in which the symbols for [MoneroBindings] can be found.
final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// The bindings to the native functions in [_dylib].
final MoneroBindings _bindings = MoneroBindings(_dylib);

/// Language codes for mnemonic generation.
enum MoneroLanguage {
  chinese(0),
  english(1),
  dutch(2),
  french(3),
  spanish(4),
  german(5),
  italian(6),
  portuguese(7),
  japanese(8),
  russian(9),
  esperanto(10),
  lojban(11),
  englishOld(12);

  final int code;
  const MoneroLanguage(this.code);
}

/// Network types for Monero.
enum MoneroNetwork {
  mainnet(0),
  testnet(1),
  stagenet(2);

  final int code;
  const MoneroNetwork(this.code);
}

/// Generates a new Monero mnemonic seed phrase.
///
/// [language] - The language for the mnemonic (default: English).
///
/// Returns a 25-word mnemonic seed phrase.
String generateMnemonic({MoneroLanguage language = MoneroLanguage.english}) {
  final mnemonicPtr = _bindings.generate_mnemonic(language.code);
  if (mnemonicPtr == nullptr) {
    throw Exception('Failed to generate mnemonic');
  }

  final mnemonic = mnemonicPtr.cast<Utf8>().toDartString();
  _bindings.free_string(mnemonicPtr);

  return mnemonic;
}

/// Generates a Monero address from a mnemonic.
///
/// [mnemonic] - The mnemonic seed phrase.
/// [network] - Network type (mainnet, testnet, or stagenet).
/// [account] - Account index (default: 0)
/// [index] - Address index (default: 0).
///
/// Returns the Monero address as a string.
String generateAddress(
  String mnemonic, {
  MoneroNetwork network = MoneroNetwork.mainnet,
  int account = 0,
  int index = 0,
}) {
  final mnemonicPtr = mnemonic.toNativeUtf8();

  try {
    final addressPtr = _bindings.generate_address(
      mnemonicPtr.cast<Char>(),
      network.code,
      account,
      index,
    );

    if (addressPtr == nullptr) {
      throw Exception('Failed to generate address');
    }

    final address = addressPtr.cast<Utf8>().toDartString();
    _bindings.free_string(addressPtr);

    return address;
  } finally {
    malloc.free(mnemonicPtr);
  }
}
