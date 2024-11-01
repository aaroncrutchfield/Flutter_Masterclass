import 'package:ai_chat_app/app/di/injection.dart';
import 'package:ai_chat_app/app/di/test/test_injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final Registry testRegistry = TestRegistry(GetIt.instance);

class TestRegistry extends GetItRegistry {
  TestRegistry(super.getIt);

  @override
  Future<void> init() => _configureTestDependencies(getIt);
}

@InjectableInit(initializerName: 'initTest', generateForDir: ['test'])
Future<void> _configureTestDependencies(
  GetIt getIt,
) async => getIt.initTest(environment: 'test');
