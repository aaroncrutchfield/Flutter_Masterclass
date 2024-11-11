import 'package:ai_chat_app/app/di/data/config/get_it_config.dart';
import 'package:ai_chat_app/app/environments.dart';
import 'package:get_it/get_it.dart';

/// A dependency manager that uses GetIt to set up all the pieces
/// your app needs.
class GetItRegistrySource {
  const GetItRegistrySource(this._getIt, this._config);

  /// The container that holds all your dependencies.
  final GetIt _getIt;

  /// Instructions for how to set up all of your dependencies.
  final GetItConfig _config;

  Future<void> init(
    Environment environment,
  ) =>
      _config.configureDependencies(environment.name, _getIt);

  T get<T extends Object>({
    dynamic param1,
    dynamic param2,
  }) =>
      _getIt.get<T>(param1: param1, param2: param2);

  void reset() => _getIt.reset();

  T call<T extends Object>({
    dynamic param1,
    dynamic param2,
  }) =>
      _getIt.call<T>(param1: param1, param2: param2);

  void register<T extends Object>(
    T Function() factoryFunction,
  ) =>
      _getIt.registerFactory<T>(factoryFunction);
}
