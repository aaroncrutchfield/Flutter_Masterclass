// coverage:ignore-file
// This file uses a static function. We cannot test it directly because it is
// not a class.

import 'package:{{project_name}}/app/di/data/config/get_it_config.dart';
import 'package:{{project_name}}/app/di/data/config/test_config.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// Uses GetIt to set up all the pieces your app needs to be tested.
class GetItTestConfig implements GetItConfig {
  /// Sets up the app specifically for running tests.
  ///
  /// [environment] will usually be 'test' here, but we keep the parameter
  /// to match the blueprint (GetItConfig)
  ///
  /// [getIt] is our container for test versions of services
  ///
  /// This is like flipping a switch that puts everything in "test mode"
  /// by calling _configureTestDependencies
  @override
  Future<void> configureDependencies(
    String environment,
    GetIt getIt,
  ) =>
      _configureTestDependencies(getIt, environment);
}

/// The actual function that sets up test dependencies.
///
/// @InjectableInit tells the app to automatically find and set up
/// all the test versions of our services. The special parts are:
///
/// - initializerName: 'initTest' means we use getIt.initTest() for test setup
/// - generateForDir: ['test'] tells it to only look in the test folder
///   for services to set up (ignoring the real app services)
///
/// This function is private (starts with _) because only GetItTestConfig
/// should use it - we don't want to accidentally use test services
/// in the real app!
@InjectableInit(initializerName: 'initTest', generateForDir: ['test'])
Future<void> _configureTestDependencies(
  GetIt getIt,
  String environment,
) async =>
    getIt.initTest(environment: 'test');
