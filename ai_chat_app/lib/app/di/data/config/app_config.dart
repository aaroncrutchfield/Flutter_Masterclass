// coverage:ignore-file
// This file uses a static function. We cannot test it directly because it is
// not a class.

import 'package:ai_chat_app/app/di/data/config/app_config.config.dart';
import 'package:ai_chat_app/app/di/data/config/get_it_config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// Uses GetIt to set up all the pieces your app needs to run.
class GetItAppConfig implements GetItConfig {
  /// Starts the setup process for all app dependencies.
  ///
  /// [environment] tells us if we're running in development, staging,
  /// or production [getIt] is our main container that will hold all the
  /// app's services
  ///
  /// This is like the master switch that starts the whole setup process.
  /// It uses _configureAppDependencies to do the actual work.
  @override
  Future<void> configureDependencies(
    String environment,
    GetIt getIt,
  ) =>
      _configureAppDependencies(getIt, environment);
}

/// The function that actually sets up all app dependencies.
///
/// @InjectableInit is a special annotation that tells the app to:
/// - Look through your code for other special annotations (@injectable,
///   @singleton, etc.)
/// - Creates all the necessary services automatically
/// - Connects everything together in the right order
///
/// The 'initializerName: init' part means we can call this using getIt.init()
///
/// This function is marked with an underscore (_) which means it's private -
/// only GetItAppConfig can use it. This helps keep our code organized and safe.
@InjectableInit(initializerName: 'init')
Future<void> _configureAppDependencies(
  GetIt getIt,
  String environment,
) async =>
    getIt.init(environment: environment);
