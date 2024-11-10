import 'package:ai_chat_app/app/di/data/config/app_config.dart';
import 'package:ai_chat_app/app/di/data/config/test_config.dart';
import 'package:ai_chat_app/app/di/data/registry_source.dart';
import 'package:ai_chat_app/app/environments.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

/// The main service manager for your real app.
///
/// Example:
/// ```dart
/// // Start up the app
/// await appRegistry.init(Environment.development);
///
/// // Get a service you need
/// final authService = appRegistry.get<AuthService>();
/// ```
// coverage:ignore-start
final InjectionRegistry appRegistry = GetItInjectionRegistry(
  GetItRegistrySource(GetIt.instance, GetItAppConfig()),
);
// coverage:ignore-end

/// A special service manager just for testing.
///
/// This is the service manager you use when you're testing your app:
/// - Uses fake/mock services instead of real ones
/// - Doesn't connect to real APIs or databases
/// - Lets you test without affecting real data
///
/// Example:
/// ```dart
/// // In your test file:
/// void setUp() {
///   // Start up the test version
///   await testRegistry.init(Environment.test);
/// }
///
/// test('login works', () {
///   final authService = testRegistry.get<AuthService>();
///   // Now you can test with fake data
/// });
/// ```
final InjectionRegistry testRegistry = GetItInjectionRegistry(
  GetItRegistrySource(GetIt.instance, GetItTestConfig()),
);

/// A blueprint for managing app dependencies (like databases, services, etc.).
///
/// Think of this as a container that holds all the important parts your app
/// needs to work. It helps keep your code organized and makes it easier to
/// change parts of your app without breaking others.
abstract interface class InjectionRegistry {
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

/// The main implementation of our service manager.
class GetItInjectionRegistry implements InjectionRegistry {
  /// Creates a new manager for our services.
  ///
  /// [registrySource] is the source containing our dependencies (GetIt)
  /// that does the actual work of storing and finding things.
  const GetItInjectionRegistry(this.registrySource);

  final GetItRegistrySource registrySource;

  @override
  Future<void> init(Environment environment) => registrySource.init(
        environment,
      );

  @override
  T get<T extends Object>() => registrySource.get<T>();

  @override
  void reset() => registrySource.reset();

  @override
  T call<T extends Object>() => registrySource.call<T>();

  @override
  @visibleForTesting
  void register<T extends Object>(T Function() factoryFunction) {
    registrySource.register(factoryFunction);
  }
}
