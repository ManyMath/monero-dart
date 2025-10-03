import 'dart:ffi';
import 'dart:io';

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

/// A very short-lived native function.
///
/// For very short-lived functions, it is fine to call them on the main isolate.
int sum(int a, int b) => _bindings.sum(a, b);
