import 'package:injectable/injectable.dart';

/// Constants for defining different execution environments in the application.
///
/// These environment constants are used with injectable's [Environment] annotation
/// to configure environment-specific dependencies.

/// Development environment configuration.
const development = Environment('development');

/// Staging environment configuration.
const staging = Environment('staging');

/// Production environment configuration.
const production = Environment('production');
