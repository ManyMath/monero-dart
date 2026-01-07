#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint monero.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'monero'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter FFI plugin project.'
  s.description      = <<-DESC
A new Flutter FFI plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'

  # If your plugin requires a privacy manifest, for example if it collects user
  # data, update the PrivacyInfo.xcprivacy file to describe your plugin's
  # privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'monero_privacy' => ['Resources/PrivacyInfo.xcprivacy']}

  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'

  # Start Cargokit:
  s.source       = { :path => '.' }
  s.source_files = 'Classes/**/*'

  s.script_phase = {
    :name => 'Build Rust library',
    # First argument: relative path to Rust folder, second: Rust library name.
    :script => 'sh "$PODS_TARGET_SRCROOT/../cargokit/build_pod.sh" ../rust monero_ffi',
    :execution_position => :before_compile,
    :input_files => ['${BUILT_PRODUCTS_DIR}/cargokit_phony'],
    # Let Xcode know the static lib output of this script (for linking).
    :output_files => ["${BUILT_PRODUCTS_DIR}/libmonero_ffi.a"],
  }
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    # Exclude 32-bit iOS simulator arch which Flutter doesn't support.
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    # Force-load the Rust static library at link time.
    'OTHER_LDFLAGS' => '-force_load ${BUILT_PRODUCTS_DIR}/libmonero_ffi.a',
  }
  # End Cargokit.
end
