import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  // Check if pubspec.yaml exists
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) {
    throw 'This doesn\'t appear to be a Flutter project (no pubspec.yaml found)';
  }

  // Check if it's a Flutter project
  final content = await pubspec.readAsString();
  if (!content.contains('flutter:')) {
    throw 'This doesn\'t appear to be a Flutter project (no flutter: section in pubspec.yaml)';
  }
}
