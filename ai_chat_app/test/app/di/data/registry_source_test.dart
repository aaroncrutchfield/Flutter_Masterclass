import 'package:ai_chat_app/app/di/data/config/get_it_config.dart';
import 'package:ai_chat_app/app/di/data/registry_source.dart';
import 'package:ai_chat_app/app/environments.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockGetIt extends Mock implements GetIt {}

class MockGetItConfig extends Mock implements GetItConfig {}

void main() {
  group('GetItRegistrySource', () {
    late GetItRegistrySource registrySource;
    late MockGetIt mockGetIt;
    late MockGetItConfig mockConfig;

    setUp(() {
      mockGetIt = MockGetIt();
      mockConfig = MockGetItConfig();
      registrySource = GetItRegistrySource(mockGetIt, mockConfig);
    });

    test('initInitializesDependenciesCorrectly', () async {
      const environment = Environment.development;
      when(() => mockConfig.configureDependencies(environment.name, mockGetIt))
          .thenAnswer((_) async => Future.value());
      await registrySource.init(environment);
      verify(
        () => mockConfig.configureDependencies(environment.name, mockGetIt),
      ).called(1);
    });

    test('getReturnsRegisteredInstance', () {
      final instance = Object();
      when(() => mockGetIt.get<Object>()).thenReturn(instance);
      final result = registrySource.get<Object>();
      expect(result, instance);
    });

    test('callReturnsRegisteredInstance', () {
      final instance = Object();
      when(() => mockGetIt.call<Object>()).thenReturn(instance);
      final result = registrySource.call<Object>();
      expect(result, instance);
    });

    test('resetCallsGetItReset', () {
      when(() => mockGetIt.reset()).thenAnswer((_) async => Future.value());
      registrySource.reset();
      verify(() => mockGetIt.reset()).called(1);
    });
  });
}
