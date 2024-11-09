import 'package:get_it/get_it.dart';

/// A blueprint for setting up your app's services and features using GetIt.
// ignore: one_member_abstracts
abstract interface class GetItConfig {
  /// Sets up all the important pieces your app needs.
  ///
  /// [environment] tells us where the app is running:
  ///   - development (when you're building new features)
  ///   - staging (final testing before release)
  ///   - production (when the app is live)
  ///   - testing (when running automated tests)
  ///
  /// [getIt] is the container where we'll put all our services
  /// so we can use them later in the app.
  ///
  /// This is marked as Future<void> because:
  /// 1. It might take some time to set everything up (that's the Future part)
  /// 2. It doesn't return anything when it's done (that's the void part)
  Future<void> configureDependencies(String environment, GetIt getIt);
}
