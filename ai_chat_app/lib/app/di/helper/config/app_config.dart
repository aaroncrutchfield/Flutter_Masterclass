// coverage:ignore-file

import 'package:ai_chat_app/app/di/helper/config/app_config.config.dart';
import 'package:ai_chat_app/app/di/helper/config/get_it_config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// Sets up all the pieces your app needs to run.
///
/// Think of this as the main setup coordinator for your app. It's like
/// a checklist that makes sure everything is ready before the app starts:
/// - Gets the right settings for your environment (dev, staging, prod)
/// - Sets up all services (like Firebase, authentication, etc.)
/// - Makes sure everything is connected properly
class GetItAppConfig implements GetItConfig {
  /// Starts the setup process for all app dependencies.
  ///
  /// [environment] tells us if we're running in development, staging, or production
  /// [getIt] is our main container that will hold all the app's services
  ///
  /// This is like the master switch that starts the whole setup process.
  /// It uses _configureAppDependencies to do the actual work.
  @override
  Future<void> configureDependencies(
      String environment,
      GetIt getIt,
      ) => _configureAppDependencies(getIt, environment);
}

/// The function that actually sets up all app dependencies.
///
/// @InjectableInit is like a magic wand that:
/// - Looks through your code for special annotations (@injectable, @singleton, etc.)
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
    ) async => getIt.init(environment: environment);