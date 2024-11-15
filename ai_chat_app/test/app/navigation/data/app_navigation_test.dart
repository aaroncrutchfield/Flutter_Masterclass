import 'package:ai_chat_app/app/navigation/data/auto_route/auto_router.dart';
import 'package:ai_chat_app/app/navigation/app_navigation.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRootAutoRouter extends Mock implements RootAutoRouter {}

class MockRouterConfig extends Mock implements RouterConfig<UrlState> {}

void main() {
  group('AutoRouteNavigation', () {
    late AutoRouteNavigation sut;
    late MockRootAutoRouter mockRouter;

    setUp(() {
      mockRouter = MockRootAutoRouter();
      sut = AutoRouteNavigation(mockRouter);
    });

    group('routerConfig', () {
      test('should return router config from RootAutoRouter', () {
        // Arrange
        final mockConfig = MockRouterConfig();
        when(() => mockRouter.config()).thenReturn(mockConfig);

        // Act
        final result = sut.routerConfig();

        // Assert
        expect(result, equals(mockConfig));
        verify(() => mockRouter.config()).called(1);
      });
    });

    group('navigateNamed', () {
      test('should delegate to RootAutoRouter.navigateNamed with correct name',
          () async {
        // Arrange
        const routeName = '/test-route';
        when(() => mockRouter.navigateNamed(routeName))
            .thenAnswer((_) async => {});

        // Act
        await sut.navigateNamed(routeName);

        // Assert
        verify(() => mockRouter.navigateNamed(routeName)).called(1);
      });

      test('should propagate errors from navigateNamed', () {
        // Arrange
        const routeName = '/test-route';
        final error = Exception('Navigation failed');
        when(() => mockRouter.navigateNamed(routeName)).thenThrow(error);

        // Act & Assert
        expect(() => sut.navigateNamed(routeName), throwsA(equals(error)));
      });
    });

    group('pushNamed', () {
      test('should delegate to RootAutoRouter.pushNamed with correct name',
          () async {
        // Arrange
        const routeName = '/test-route';
        const expectedResult = 'result';
        when(() => mockRouter.pushNamed<String>(routeName))
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await sut.pushNamed<String>(routeName);

        // Assert
        expect(result, equals(expectedResult));
        verify(() => mockRouter.pushNamed<String>(routeName)).called(1);
      });

      test('should handle null result from pushNamed', () async {
        // Arrange
        const routeName = '/test-route';
        when(() => mockRouter.pushNamed<String>(routeName))
            .thenAnswer((_) async => null);

        // Act
        final result = await sut.pushNamed<String>(routeName);

        // Assert
        expect(result, isNull);
        verify(() => mockRouter.pushNamed<String>(routeName)).called(1);
      });

      test('should propagate errors from pushNamed', () {
        // Arrange
        const routeName = '/test-route';
        final error = Exception('Push failed');
        when(() => mockRouter.pushNamed<String>(routeName)).thenThrow(error);

        // Act & Assert
        expect(() => sut.pushNamed<String>(routeName), throwsA(equals(error)));
      });
    });

    group('maybePop', () {
      test('should delegate to RootAutoRouter.maybePop without result',
          () async {
        // Arrange
        when(() => mockRouter.maybePop<void>())
            .thenAnswer((_) => Future.value(true));

        // Act
        final result = await sut.maybePop<void>();

        // Assert
        expect(result, isTrue);
        verify(() => mockRouter.maybePop<void>());
      });

      test('should delegate to RootAutoRouter.maybePop with result', () async {
        // Arrange
        const popResult = 'test-result';
        when(() => mockRouter.maybePop<String>(popResult))
            .thenAnswer((_) async => true);

        // Act
        final result = await sut.maybePop<String>(popResult);

        // Assert
        expect(result, isTrue);
        verify(() => mockRouter.maybePop<String>(popResult)).called(1);
      });

      test('should handle false result from maybePop', () async {
        // Arrange
        when(() => mockRouter.maybePop<void>())
            .thenAnswer((_) => Future.value(false));

        // Act
        final result = await sut.maybePop<void>();

        // Assert
        expect(result, isFalse);
        verify(() => mockRouter.maybePop<void>()).called(1);
      });

      test('should propagate errors from maybePop', () {
        // Arrange
        final error = Exception('Pop failed');
        when(() => mockRouter.maybePop<void>())
            .thenAnswer((_) => Future.error(error));

        // Act & Assert
        expect(() => sut.maybePop<void>(), throwsA(equals(error)));
      });
    });
  });
}
