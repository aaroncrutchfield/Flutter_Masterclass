import 'package:{{project_name}}/app/di/data/get_it/get_it_registry_source.dart';
import 'package:{{project_name}}/app/di/data/injectable/injectable_config.dart';
import 'package:{{project_name}}/app/environments.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

/// Global instance of the dependency injection registry.
/// Ignored for code coverage.
// coverage:ignore-start
final InjectionRegistry appRegistry = GetItInjectionRegistry(
  GetItRegistrySource(GetIt.instance, InjectableConfig()),
);
// coverage:ignore-end

/// Interface for managing dependency injection in the application.
abstract interface class InjectionRegistry {
  /// Initializes the dependency injection container for the given environment.
  Future<void> init(Environment environment);

  /// Retrieves a dependency of type [T] from the container.
  ///
  /// Optional [param1] and [param2] can be passed for factory functions.
  T get<T extends Object>({
    dynamic param1,
    dynamic param2,
  });

  /// Shorthand operator for retrieving dependencies.
  ///
  /// Functions identically to [get].
  T call<T extends Object>({
    dynamic param1,
    dynamic param2,
  });

  /// Resets the dependency container to its initial state.
  void reset();

  /// Registers a factory function for type [T].
  ///
  /// Only available for testing purposes.
  void register<T extends Object>(T Function() factoryFunction);
}

/// Implementation of [InjectionRegistry] using GetIt for dependency injection.
class GetItInjectionRegistry implements InjectionRegistry {
  /// Creates a new instance with the provided registry source.
  const GetItInjectionRegistry(this.registrySource);

  /// The underlying source for registry operations.
  final GetItRegistrySource registrySource;

  @override
  Future<void> init(Environment environment) => registrySource.init(
        environment,
      );

  @override
  T get<T extends Object>({
    dynamic param1,
    dynamic param2,
  }) =>
      registrySource.get<T>(param1: param1, param2: param2);

  @override
  void reset() => registrySource.reset();

  @override
  T call<T extends Object>({
    dynamic param1,
    dynamic param2,
  }) =>
      registrySource.call<T>(param1: param1, param2: param2);

  @override
  @visibleForTesting
  void register<T extends Object>(T Function() factoryFunction) {
    registrySource.register(factoryFunction);
  }
}
