import 'package:ai_chat_app/app/di/app/app_injection.config.dart';
import 'package:ai_chat_app/app/di/injection.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final Registry appRegistry = AppRegistry(GetIt.instance);


class AppRegistry extends GetItRegistry {
  AppRegistry(super.getIt);

  @override
  Future<void> init() => _configureAppDependencies(getIt);
}

@InjectableInit(initializerName: 'init')
Future<void> _configureAppDependencies(GetIt getIt) => getIt.init();
