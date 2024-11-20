import 'package:{{project_name.snakeCase()}}/app/di/data/injectable/injectable_config.dart';
import 'package:{{project_name.snakeCase()}}/app/environments.dart';
import 'package:get_it/get_it.dart';

/// A wrapper class for managing dependency injection using GetIt.
class GetItRegistrySource {
  /// Creates a new instance with the provided GetIt instance and configuration.
  ///
  /// [_getIt] The GetIt instance to use for dependency resolution.
  /// [_config] The configuration for setting up dependencies.
  const GetItRegistrySource(this._getIt, this._config);

  final GetIt _getIt;
  final InjectableConfig _config;

  /// Initializes dependencies for the specified environment.
  ///
  /// [environment] The environment configuration to use.
  Future<void> init(Environment environment) =>
      _config.configureDependencies(environment.name, _getIt);

  /// Retrieves an instance of type [T] from the dependency container.
  ///
  /// [param1] Optional first parameter for factory functions.
  /// [param2] Optional second parameter for factory functions.
  T get<T extends Object>({
    dynamic param1,
    dynamic param2,
  }) =>
      _getIt.get<T>(param1: param1, param2: param2);

  /// Resets all registered dependencies.
  void reset() => _getIt.reset();

  /// Shorthand operator for retrieving dependencies.
  ///
  /// Provides the same functionality as [get] but through call syntax.
  T call<T extends Object>({
    dynamic param1,
    dynamic param2,
  }) =>
      _getIt.call<T>(param1: param1, param2: param2);

  /// Registers a factory function for type [T].
  ///
  /// [factoryFunction] The function that creates instances of [T].
  void register<T extends Object>(
    T Function() factoryFunction,
  ) =>
      _getIt.registerFactory<T>(factoryFunction);
}
