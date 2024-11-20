import 'dart:io';
import 'package:mason/mason.dart';

class BuildRunnerUtils {
  const BuildRunnerUtils(this._logger);

  final Logger _logger;

  /// Run build_runner build with delete conflicting outputs
  Future<void> generateFiles() async {
    final progress = _logger.progress('Running build_runner');

    try {
      final result = await Process.run(
        'dart',
        ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
        runInShell: true,
      );

      if (result.exitCode != 0) {
        progress.fail('Failed to run build_runner');
        _logger.err(result.stderr.toString());
        throw Exception('Build runner failed: ${result.stderr}');
      }

      progress.complete('Generated files successfully!');
    } catch (e) {
      progress.fail('Failed to run build_runner');
      rethrow;
    }
  }
}
