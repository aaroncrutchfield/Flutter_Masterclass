import 'dart:io';
import 'package:mason/mason.dart';

import 'package:very_good_core_hooks/src/models/dependencies.dart';

class DependencyUtils {
  const DependencyUtils(
    this._logger,
    this._dependencies,
    this._devDependencies,
  );

  final Logger _logger;
  final List<Dependency> _dependencies;
  final List<DevDependency> _devDependencies;

  /// Install all regular dependencies
  Future<void> installDependencies() async {
    _logger.detail('Installing dependencies');

    try {
      // Regular dependencies
      final dependencies = _dependencies.map((e) => e.id);
      for (final package in dependencies) {
        await _addPackage(package, isDev: false);
      }

      // Dev dependencies
      final devDependencies = _devDependencies.map((e) => e.id);
      for (final package in devDependencies) {
        await _addPackage(package, isDev: true);
      }

      _logger.success('All dependencies installed successfully!');
    } catch (e) {
      _logger.err('Failed to install dependencies');
      rethrow;
    }
  }

  /// Add a single package to the project
  Future<void> _addPackage(
    String package, {
    required bool isDev,
  }) async {
    final args = ['pub', 'add', if (isDev) '--dev', package];

    final progress = _logger.progress('Adding $package');
    final result = await Process.run(
      'flutter',
      args,
      runInShell: true,
    );

    if (result.exitCode != 0) {
      progress.fail('Failed to add $package');
    } else {
      progress.complete('$package added');
    }
  }
}
