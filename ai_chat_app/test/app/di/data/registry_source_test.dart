import 'package:ai_chat_app/app/di/data/config/get_it_config.dart';
import 'package:ai_chat_app/app/di/data/registry_source.dart';
import 'package:ai_chat_app/app/environments.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockGetIt extends Mock implements GetIt {}

class MockGetItConfig extends Mock implements GetItConfig {}

void main() {
  late GetItRegistrySource sut;
  late MockGetIt mockGetIt;
  late MockGetItConfig mockConfig;

  setUpAll(() {
    registerFallbackValue(Environment.development);
  });

  setUp(() {
    mockGetIt = MockGetIt();
    mockConfig = MockGetItConfig();
    sut = GetItRegistrySource(mockGetIt, mockConfig);
  });

  group('GetItRegistrySource', () {
    test('init should call configureDependencies with correct parameters',
        () async {
      // Arrange
      const environment = Environment.development;
      when(() => mockConfig.configureDependencies(environment.name, mockGetIt))
          .thenAnswer((_) async => {});

      // Act
      await sut.init(environment);

      // Assert
      verify(
        () => mockConfig.configureDependencies(
          environment.name,
          mockGetIt,
        ),
      );
    });

    test('get should delegate to GetIt with correct parameters', () {
      // Arrange
      const param1 = 'test1';
      const param2 = 'test2';
      const expectedValue = 'result';
      when(() => mockGetIt.get<String>(param1: param1, param2: param2))
          .thenReturn(expectedValue);

      // Act
      final result = sut.get<String>(param1: param1, param2: param2);

      // Assert
      expect(result, expectedValue);
      verify(() => mockGetIt.get<String>(param1: param1, param2: param2))
          .called(1);
    });

    test('reset should delegate to GetIt', () {
      // Arrange
      when(() => mockGetIt.reset()).thenAnswer((_) => Future.value());

      // Act
      sut.reset();

      // Assert
      verify(() => mockGetIt.reset());
    });

    test('call should delegate to GetIt with correct parameters', () {
      // Arrange
      const param1 = 'test1';
      const param2 = 'test2';
      const expectedValue = 'result';
      when(() => mockGetIt.call<String>(param1: param1, param2: param2))
          .thenReturn(expectedValue);

      // Act
      final result = sut.call<String>(param1: param1, param2: param2);

      // Assert
      expect(result, expectedValue);
      verify(() => mockGetIt.call<String>(param1: param1, param2: param2));
    });

    test(
        'register should delegate to GetIt registerFactory with correct function',
        () {
      // Arrange
      String factoryFunction() => 'test';
      when(() => mockGetIt.registerFactory<String>(any())).thenReturn(null);

      // Act
      sut.register<String>(factoryFunction);

      // Assert
      verify(() => mockGetIt.registerFactory<String>(any()));
    });

    test('should throw when GetIt throws', () {
      // Arrange
      when(() => mockGetIt.get<String>())
          .thenThrow(Exception('Not registered'));

      // Act & Assert
      expect(() => sut.get<String>(), throwsException);
    });
  });
}
