import 'package:ai_chat_app/app/di/helper/config/get_it_config.dart';
import 'package:ai_chat_app/app/environments.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

/// A blueprint for managing app dependencies (like databases, services, etc.).
///
/// Think of this as a container that holds all the important parts your app needs
/// to work. It helps keep your code organized and makes it easier to change
/// parts of your app without breaking others.
abstract interface class DependencyRegistrySource {
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

  /// Cleans up everything in the registry.
  ///
  /// Be careful with this! It's like unplugging everything -
  /// your app might stop working until you set things up again.
  void reset();

  void register<T extends Object>(T Function() factoryFunction);
}

/// A way to organize app dependencies using the GetIt package.
///
/// This helps manage all the pieces of your app (like services, databases,
/// and other important stuff) in one place. It makes it easy to:
/// - Start up your app with everything it needs
/// - Get access to important stuff from anywhere in your app
/// - Change parts of your app without breaking other parts
class GetItRegistrySource implements DependencyRegistrySource {
  /// Creates a new dependency manager.
  ///
  /// [getIt] is the main container that holds all your app's important pieces.
  /// [config] is like a recipe book that tells how to set everything up.
  const GetItRegistrySource(this.getIt, this.config);

  /// The container that holds all your app's dependencies.
  ///
  /// This is marked as @protected which means only this class and its
  /// subclasses can use it directly - this keeps things safe and organized.
  @protected
  final GetIt getIt;

  /// Instructions for how to set up your app's dependencies.
  ///
  /// Like a blueprint that says what needs to be set up and how.
  @protected
  final GetItConfig config;

  @override
  Future<void> init(
    Environment environment,
  ) => config.configureDependencies(environment.name, getIt);

  @override
  T get<T extends Object>() => getIt.get<T>();

  @override
  void reset() => getIt.reset();

  @override
  T call<T extends Object>() => getIt.call<T>();

  @override
  void register<T extends Object>(
    T Function() factoryFunction,
  ) => getIt.registerFactory<T>(factoryFunction);
}
