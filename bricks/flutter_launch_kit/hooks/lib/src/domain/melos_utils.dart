// hooks/lib/src/melos_utils.dart
import 'dart:io';
import 'package:mason/mason.dart';

class MelosUtils {
  const MelosUtils(this._logger);

  final Logger _logger;

  /// Check if melos is available in PATH
  Future<bool> isMelosAvailable() async {
    try {
      final result = await Process.run('melos', ['--version']);
      return result.exitCode == 0;
    } catch (e) {
      return false;
    }
  }

  /// Run melos bootstrap in specified directory
  Future<void> bootstrap() async {
    final progress = _logger.progress('Running melos bootstrap');

    try {
      if (!await isMelosAvailable()) {
        progress.fail(
          'Melos not found. Please ensure it was installed in the pre_gen hook.',
        );
        throw Exception('Melos is required to proceed.');
      }

      final result = await Process.run(
        'melos',
        ['bootstrap'],
        runInShell: true,
      );

      if (result.exitCode != 0) {
        progress.fail('Melos bootstrap failed');
        throw Exception('Melos bootstrap failed: ${result.stderr}');
      }

      progress.complete('Melos bootstrap completed successfully!');
    } catch (e) {
      progress.fail('Failed to run melos bootstrap');
      throw Exception('Failed to run melos bootstrap: $e');
    }
  }

  /// Install melos if not already installed
  Future<void> install() async {
    final progress = _logger.progress('Installing Melos CLI');

    try {
      final result = await Process.run(
        'dart',
        ['pub', 'global', 'activate', 'melos'],
        runInShell: true,
      );

      if (result.exitCode != 0) {
        progress.fail('Failed to install Melos');
        throw Exception('Failed to install Melos: ${result.stderr}');
      }

      progress.complete('Melos installed successfully!');
    } catch (e) {
      progress.fail('Failed to install Melos');
      throw Exception('Failed to install Melos: $e');
    }
  }
}
