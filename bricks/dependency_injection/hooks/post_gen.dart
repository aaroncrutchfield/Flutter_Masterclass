import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Installing dependencies');

  // List of required dependencies
  final dependencies = [
    'bloc',
    'flutter_bloc',
    'firebase_auth',
    'firebase_ui_auth',
    'firebase_core',
    'get_it',
    'injectable',
  ];

  // List of dev dependencies
  final devDependencies = [
    'bloc_test',
    'build_runner',
    'injectable_generator',
    'mocktail',
  ];

  // Install regular dependencies
  for (final package in dependencies) {
    final result = await Process.run(
      'flutter',
      ['pub', 'add', package],
      runInShell: true,
    );

    if (result.exitCode != 0) {
      progress.fail('\nFailed to add $package');
      context.logger.err(result.stderr);
      return;
    }
    context.logger.success('\nAdded $package');
  }

  // Install dev dependencies
  for (final package in devDependencies) {
    final result = await Process.run(
      'flutter',
      ['pub', 'add', '--dev', package],
      runInShell: true,
    );

    if (result.exitCode != 0) {
      progress.fail('\nFailed to add $package');
      context.logger.err(result.stderr);
      return;
    }
    context.logger.success('\nAdded $package');
  }

  progress.complete('Dependencies installed!');

  // Run build_runner
  final buildProgress = context.logger.progress('Running build_runner');

  final buildRunner = await Process.run(
    'dart',
    ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    runInShell: true,
  );

  if (buildRunner.exitCode != 0) {
    buildProgress.fail('Failed to run build_runner');
    context.logger.err(buildRunner.stderr);
    return;
  }

  buildProgress.complete('Generated files successfully!');

  context.logger.success('''
  
✓ Dependencies installed
✓ Dependency injection files generated
✓ Injectable config files generated with build_runner
  
Next steps:
1. Check the generated files in lib/app/di/
2. Add your dependencies to the appropriate config files
3. Set up your Firebase configuration in firebase_options_dev.dart
4. Run build_runner again if you make changes to @injectable classes

Note: If you haven't set up Firebase yet, you'll need to:
1. Install the Firebase CLI
2. Run 'flutterfire configure'
3. Follow the Firebase setup instructions
''');
}
