/// Collection of production dependencies used in the project
///
/// Each enum value corresponds to a package from pub.dev
enum Dependency {
  /// State management library
  ///
  /// See: https://pub.dev/packages/bloc
  bloc('bloc'),

  /// Flutter widgets for bloc state management
  ///
  /// See: https://pub.dev/packages/flutter_bloc
  flutterBloc('flutter_bloc'),

  /// Internationalization and localization support
  ///
  /// See: https://pub.dev/packages/intl
  intl('intl'),

  /// Service locator for dependency injection
  ///
  /// See: https://pub.dev/packages/get_it
  getIt('get_it'),

  /// Code generation for dependency injection
  ///
  /// See: https://pub.dev/packages/injectable
  injectable('injectable');

  const Dependency(this.id);

  /// The package id on pub.dev
  final String id;
}

/// Collection of development dependencies used in the project
///
/// These dependencies are only used during development and testing
enum DevDependency {
  /// Testing utilities for bloc
  ///
  /// See: https://pub.dev/packages/bloc_test
  blocTest('bloc_test'),

  /// Mocking library for testing
  ///
  /// See: https://pub.dev/packages/mocktail
  mocktail('mocktail'),

  /// Strict lint rules for Dart and Flutter projects
  ///
  /// See: https://pub.dev/packages/very_good_analysis
  veryGoodAnalysis('very_good_analysis'),

  /// Code generation tool
  ///
  /// See: https://pub.dev/packages/build_runner
  buildRunner('build_runner'),

  /// Code generator for injectable
  ///
  /// See: https://pub.dev/packages/injectable_generator
  injectableGenerator('injectable_generator');

  const DevDependency(this.id);

  /// The package id on pub.dev
  final String id;
}
