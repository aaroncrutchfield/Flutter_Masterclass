import 'package:ai_chat_app/app/di/data/config/get_it_config.dart';
import 'package:ai_chat_app/app/environments.dart';
import 'package:get_it/get_it.dart';

/// A blueprint for managing app dependencies (like databases, services, etc.).
///
/// Think of this as a container that holds all the important parts your app
/// needs to work. It helps keep your code organized and makes it easier to
/// change parts of your app without breaking others.
abstract interface class RegistrySource {
  /// Sets up all the important parts your app needs.
  ///
  /// [environment] tells the app whether it's running in development,
  /// testing, or production mode. This helps configure things differently
  /// based on where the app is running.
  Future<void> init(Environment environment);

  /// Gets something your app needs (like a database connection or service).
  ///
  /// Example:
  /// ```dart
  /// final database = registry.get<Database>();
  /// ```
  T get<T extends Object>();

  /// Works just like [get], but lets you use shorter code.
  ///
  /// Instead of writing registry.get<Database>(),
  /// you can write registry<Database>()
  T call<T extends Object>();

  /// Removes all registered dependencies from the container.
  void reset();

  void register<T extends Object>(T Function() factoryFunction);
}

/// A dependency manager that uses GetIt to manage dependencies.
///
/// This is like the manager of our organized closet. It knows:
/// - Where everything is stored
/// - How to get things when needed
/// - How to keep everything organized
class GetItRegistrySource implements RegistrySource {
  const GetItRegistrySource(this._getIt, this._config);

  /// The container that holds all your dependencies.
  final GetIt _getIt;

  /// Instructions for how to set up all of your dependencies.
  final GetItConfig _config;

  @override
  Future<void> init(
    Environment environment,
  ) =>
      _config.configureDependencies(environment.name, _getIt);

  @override
  T get<T extends Object>() => _getIt.get<T>();

  @override
  void reset() => _getIt.reset();

  @override
  T call<T extends Object>() => _getIt.call<T>();

  @override
  void register<T extends Object>(
    T Function() factoryFunction,
  ) =>
      _getIt.registerFactory<T>(factoryFunction);
}
