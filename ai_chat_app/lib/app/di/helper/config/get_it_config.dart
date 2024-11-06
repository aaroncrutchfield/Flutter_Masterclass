import 'package:get_it/get_it.dart';


/// A blueprint for setting up your app's services and features.
///
/// Think of this as a contract that says "any class that implements this
/// must know how to set up the app's important pieces." It's like a recipe
/// that says what needs to be done, but doesn't specify exactly how to do it.
///
/// For example:
/// - One implementation might set up services for development (while you're
///   building features)
/// - Another might set up services for testing (when running automated tests)
/// - Both follow this blueprint but do things differently (like using
/// fake data for tests)
// ignore: one_member_abstracts
abstract interface class GetItConfig {
  /// Sets up all the important pieces your app needs.
  ///
  /// [environment] tells us where the app is running:
  ///   - 'dev' for development (when you're building new features)
  ///   - 'test' for testing (when running automated tests)
  ///   - 'stg' for staging (final testing before release)
  ///
  /// [getIt] is like a container where we'll put all our services
  /// so we can use them later in the app.
  ///
  /// This is marked as Future<void> because:
  /// 1. It might take some time to set everything up (that's the Future part)
  /// 2. It doesn't return anything when it's done (that's the void part)
  Future<void> configureDependencies(String environment, GetIt getIt);
}
