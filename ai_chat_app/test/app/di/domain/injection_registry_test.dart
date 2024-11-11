import 'package:ai_chat_app/app/di/data/registry_source.dart';
import 'package:ai_chat_app/app/di/domain/injection_registry.dart';
import 'package:ai_chat_app/app/environments.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetItRegistrySource extends Mock implements GetItRegistrySource {}

void main() {
  group('GetItInjectionRegistry', () {
    late GetItInjectionRegistry sut;
    late MockGetItRegistrySource mockRegistrySource;

    setUp(() {
      mockRegistrySource = MockGetItRegistrySource();
      sut = GetItInjectionRegistry(mockRegistrySource);
    });

    group('init', () {
      test('should delegate to registrySource.init with correct environment',
          () async {
        // Arrange
        const environment = Environment.development;
        when(() => mockRegistrySource.init(environment))
            .thenAnswer((_) async => {});

        // Act
        await sut.init(environment);

        // Assert
        verify(() => mockRegistrySource.init(environment)).called(1);
      });

      test('should propagate errors from registrySource.init', () async {
        // Arrange
        const environment = Environment.development;
        final error = Exception('Init failed');
        when(() => mockRegistrySource.init(environment)).thenThrow(error);

        // Act & Assert
        expect(() => sut.init(environment), throwsA(equals(error)));
      });
    });

    group('get', () {
      test('should delegate to registrySource.get with correct parameters', () {
        // Arrange
        const param1 = 'test1';
        const param2 = 'test2';
        const expectedValue = 'result';
        when(
          () => mockRegistrySource.get<String>(
            param1: param1,
            param2: param2,
          ),
        ).thenReturn(expectedValue);

        // Act
        final result = sut.get<String>(param1: param1, param2: param2);

        // Assert
        expect(result, expectedValue);
        verify(
          () => mockRegistrySource.get<String>(
            param1: param1,
            param2: param2,
          ),
        ).called(1);
      });

      test('should work without parameters', () {
        // Arrange
        const expectedValue = 'result';
        when(() => mockRegistrySource.get<String>()).thenReturn(expectedValue);

        // Act
        final result = sut.get<String>();

        // Assert
        expect(result, expectedValue);
        verify(() => mockRegistrySource.get<String>()).called(1);
      });
    });

    group('call', () {
      test('should delegate to registrySource.call with correct parameters',
          () {
        // Arrange
        const param1 = 'test1';
        const param2 = 'test2';
        const expectedValue = 'result';
        when(
          () => mockRegistrySource.call<String>(
            param1: param1,
            param2: param2,
          ),
        ).thenReturn(expectedValue);

        // Act
        final result = sut<String>(param1: param1, param2: param2);

        // Assert
        expect(result, expectedValue);
        verify(
          () => mockRegistrySource.call<String>(
            param1: param1,
            param2: param2,
          ),
        ).called(1);
      });

      test('should work without parameters', () {
        // Arrange
        const expectedValue = 'result';
        when(() => mockRegistrySource.call<String>()).thenReturn(expectedValue);

        // Act
        final result = sut<String>();

        // Assert
        expect(result, expectedValue);
        verify(() => mockRegistrySource.call<String>()).called(1);
      });
    });

    group('reset', () {
      test('should delegate to registrySource.reset', () {
        // Arrange
        when(() => mockRegistrySource.reset()).thenReturn(null);

        // Act
        sut.reset();

        // Assert
        verify(() => mockRegistrySource.reset()).called(1);
      });
    });

    group('register', () {
      test(
          'should delegate to registrySource.register '
              'with correct factory function',
          () {
        // Arrange
        String factoryFunction() => 'test';
        when(() => mockRegistrySource.register<String>(any())).thenReturn(null);

        // Act
        sut.register<String>(factoryFunction);

        // Assert
        verify(() => mockRegistrySource.register<String>(any())).called(1);
      });

      test('should propagate registration errors', () {
        // Arrange
        String factoryFunction() => 'test';
        final error = Exception('Registration failed');
        when(() => mockRegistrySource.register<String>(any())).thenThrow(error);

        // Act & Assert
        expect(
          () => sut.register<String>(factoryFunction),
          throwsA(equals(error)),
        );
      });
    });

    group('global instances', () {
      test('appRegistry should be initialized with GetItAppConfig', () {
        expect(appRegistry, isA<GetItInjectionRegistry>());
      });

      test('testRegistry should be initialized with GetItTestConfig', () {
        expect(testRegistry, isA<GetItInjectionRegistry>());
      });
    });
  });
}
