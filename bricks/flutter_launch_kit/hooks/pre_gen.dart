import 'dart:io';

import 'package:clock/clock.dart';
import 'package:flutter_launch_kit_app/hooks.dart';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final configuration = VeryGoodCoreConfiguration.fromHookVars(context.vars);

  await installMelos(context);

  context.vars = {
    /// Below are all the variables that are accessible in the templates.
    ///
    /// You can access them using the Mustache syntax within the template files
    /// (those under `__brick__`). For example:
    ///
    /// ```dart
    /// // __brick__/pubspec.yaml
    /// name: {{project_name}}
    /// ```
    ///
    /// This will be replaced with the value of the `project_name` variable.
    ///
    /// By design, Mustache is a  "logic-less" template language, meaning it
    /// does not have the ability to construct logical expressions. From the
    /// documentation:
    ///
    /// > We call it "logic-less" because there are no if statements, else
    /// > clauses, or for loops. Instead there are only tags.
    ///
    /// This means that you can't use Mustache to add logical expressions to
    /// your templates. If you need to add logical expressions, you should
    /// evaluate the expression within this pre-generation hook (`pre_gen.dart`)
    /// and pass the result as a variable to the template.
    ///
    /// See also:
    ///
    /// * [Mustache documentation](https://mustache.github.io/mustache.5.html)
    /// * [Mason conditional documentation](https://docs.brickhub.dev/brick-syntax#-conditionals)
    'project_name': configuration.projectName,
    'org_name': configuration.organizationName,
    'description': configuration.description,
    'android_namespace': configuration.androidNamespace,
    'android_application_id': configuration.androidApplicationId,
    'ios_application_id': configuration.iOsApplicationId,
    'macos_application_id': configuration.macOsApplicationId,
    'windows_application_id': configuration.windowsApplicationId,
    'current_year': clock.now().year.toString(),
  };
}

Future<void> installMelos(HookContext context) async {
  final progress = context.logger.progress('Installing Melos CLI');

  // Function to check if melos is activated
  Future<bool> isMelosActivated() async {
    try {
      final result = await Process.run('dart', ['pub', 'global', 'list']);
      return result.stdout.toString().contains('melos');
    } catch (e) {
      return false;
    }
  }

  try {
    // Check if dart is available
    await Process.run('dart', ['--version']);
  } catch (e) {
    progress.fail('Dart SDK not found. Please install Dart first.');
    throw Exception('Dart SDK is required to proceed.');
  }

  try {
    if (!await isMelosActivated()) {
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
    } else {
      progress.complete('Melos is already installed');
    }
  } catch (e) {
    progress.fail('Failed to install Melos');
    throw Exception('Failed to install Melos: $e');
  }
}
