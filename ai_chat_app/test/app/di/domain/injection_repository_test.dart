import 'package:ai_chat_app/app/di/data/dependency_registry_source.dart';
import 'package:ai_chat_app/app/di/domain/injection_repository.dart';
import 'package:ai_chat_app/app/environments.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDependencyRegistrySource extends Mock implements DependencyRegistrySource {}

void main() {
  group('GetItInjectionRepository', () {
    late GetItInjectionRepository repository;
    late MockDependencyRegistrySource mockDependencyRegistrySource;

    setUp(() {
      mockDependencyRegistrySource = MockDependencyRegistrySource();
      repository = GetItInjectionRepository(mockDependencyRegistrySource);
    });

    test('initInitializesDependenciesCorrectly', () async {
      const environment = Environment.development;
      when(() => mockDependencyRegistrySource.init(environment))
          .thenAnswer((_) async => Future.value());
      await repository.init(environment);
      verify(() => mockDependencyRegistrySource.init(environment)).called(1);
    });

    test('getReturnsRegisteredInstance', () {
      final instance = Object();
      when(() => mockDependencyRegistrySource.get<Object>()).thenReturn(instance);
      final result = repository.get<Object>();
      expect(result, instance);
    });

    test('callReturnsRegisteredInstance', () {
      final instance = Object();
      when(() => mockDependencyRegistrySource.call<Object>()).thenReturn(instance);
      final result = repository.call<Object>();
      expect(result, instance);
    });

    test('resetCallsDependencyRegistrySourceReset', () {
      when(() => mockDependencyRegistrySource.reset()).thenAnswer((_) async => Future.value());
      repository.reset();
      verify(() => mockDependencyRegistrySource.reset()).called(1);
    });
  });
}