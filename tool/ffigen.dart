import 'dart:io';

void main() async {
  // Run ffigen with the YAML config file
  final packageRoot = Platform.script.resolve('../');
  final configPath = packageRoot.resolve('ffigen.yaml').toFilePath();

  print('Running ffigen with config: $configPath');

  final result = await Process.run(
    'dart',
    ['run', 'ffigen', '--config', configPath],
    workingDirectory: packageRoot.toFilePath(),
  );

  stdout.write(result.stdout);
  stderr.write(result.stderr);

  exit(result.exitCode);
}
