import 'package:{{project_name}}/app/di/data/config/app_config.dart';
import 'package:{{project_name}}/app/di/data/config/test_config.dart';
import 'package:{{project_name}}/app/di/data/registry_source.dart';
import 'package:{{project_name}}/app/environments.dart';
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
final InjectionRegistry appRegistry = InjectionRegistryImpl(
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
final InjectionRegistry testRegistry = InjectionRegistryImpl(
  GetItRegistrySource(GetIt.instance, GetItTestConfig()),
);

/// Main blueprint for managing app services and features.
///
/// Think of this as a super-organized closet where all your app's
/// important pieces are stored and managed. It helps you:
/// - Start up services (like databases or login)
/// - Find and use services when needed
/// - Clean up services when you're done
///
/// This is the main way your app's different parts can get
/// access to the things they need to work.
abstract interface class InjectionRegistry {
  /// Gets everything ready to use.
  ///
  /// [environment] tells us if we're:
  /// - Building new features (development)
  /// - Running tests (test)
  /// - Getting ready for release (staging)
  Future<void> init(Environment environment);

  /// Finds and returns a service your app needs.
  ///
  /// Example:
  /// ```dart
  /// // Get the database service
  /// final database = repository.get<Database>();
  /// ```
  T get<T extends Object>();

  /// Works just like [get] but with shorter code.
  ///
  /// Instead of writing repository.get<Database>(),
  /// you can write repository<Database>()
  /// It's just a shortcut for the same thing!
  T call<T extends Object>();

  /// Cleans up all services.
  ///
  /// Like cleaning out the closet - removes everything
  /// so you can start fresh. Be careful with this!
  void reset();

  @visibleForTesting
  void register<T extends Object>(T Function() factoryFunction);
}

/// The actual implementation that uses GetIt to manage everything.
///
/// This is like the manager of our organized closet. It knows:
/// - Where everything is stored
/// - How to get things when needed
/// - How to keep everything organized
///
/// It uses DependencyRegistrySource (GetIt) to do the actual work,
/// kind of like having a helpful assistant.
class InjectionRegistryImpl implements InjectionRegistry {
  /// Creates a new manager for our services.
  ///
  /// [dependencyRegistrySource] is like our assistant (GetIt)
  /// that does the actual work of storing and finding things.
  const InjectionRegistryImpl(this.dependencyRegistrySource);

  /// Our helper that actually stores and manages services.
  ///
  /// Think of this as the actual shelves and drawers in our
  /// organized closet - it's where things really get stored.
  final RegistrySource dependencyRegistrySource;

  @override
  Future<void> init(Environment environment) => dependencyRegistrySource.init(
        environment,
      );

  @override
  T get<T extends Object>() => dependencyRegistrySource.get<T>();

  @override
  void reset() => dependencyRegistrySource.reset();

  @override
  T call<T extends Object>() => dependencyRegistrySource.call<T>();

  @override
  @visibleForTesting
  void register<T extends Object>(T Function() factoryFunction) {
    dependencyRegistrySource.register(factoryFunction);
  }
}
