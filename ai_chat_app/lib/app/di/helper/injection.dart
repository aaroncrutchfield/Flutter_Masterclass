import 'package:ai_chat_app/app/di/data/dependency_registry_source.dart';
import 'package:ai_chat_app/app/di/domain/injection_repository.dart';
import 'package:ai_chat_app/app/di/helper/config/app_config.dart';
import 'package:ai_chat_app/app/di/helper/config/test_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

/// The main service manager for your real app.
///
/// This is like the main control panel for your app that:
/// - Manages real services (databases, auth, etc.)
/// - Uses actual APIs and data
/// - Handles real user interactions
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
final InjectionRepository appRegistry = GetItInjectionRepository(
  GetItRegistrySource(GetIt.instance, GetItAppConfig()),
);
// coverage:ignore-end

/// A special service manager just for testing.
///
/// Think of this as a "practice" version of your app that:
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
final InjectionRepository testRegistry = GetItInjectionRepository(
  GetItRegistrySource(GetIt.instance, GetItTestConfig()),
);

/// Adds an easy way to access the app's service manager from widgets.
///
/// Think of this as a shortcut that lets any widget easily find
/// and use the app's services. It's like giving every widget a
/// remote control to access what it needs.
///
/// Example:
/// ```dart
/// class CounterPage extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     // Get a Cubit/Bloc easily with the shortcut
///     return BlocProvider(
///       create: (ctx) => context.appRegistry<CounterCubit>(),
///       child: const CounterView(),
///     );
///   }
/// }
/// ```
///
/// Instead of writing long code like:
/// ```dart
/// context.read<InjectionRepository>().get<CounterCubit>()
/// ```
///
/// You can write the shorter, cleaner:
/// ```dart
/// context.appRegistry<CounterCubit>()
/// ```
extension InjectionX on BuildContext {
  /// Gets the app's service manager.
  ///
  /// This uses Bloc's built-in 'read' method to find
  /// the InjectionRepository that was set up earlier in
  /// your app (main.dart).
  InjectionRepository get appRegistry => read<InjectionRepository>();
}
