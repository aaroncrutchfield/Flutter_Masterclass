import 'package:ai_chat_app/core/auth/auth_repository.dart';
import 'package:ai_chat_app/core/auth/data/auth_remote_data_source.dart';
import 'package:ai_chat_app/core/auth/data/auth_user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late MockAuthRemoteDataSource authRemoteDataSource;
  late FirebaseAuthRepository authRepository;

  setUp(() {
    authRemoteDataSource = MockAuthRemoteDataSource();
    authRepository = FirebaseAuthRepository(authRemoteDataSource);
  });

  group('FirebaseAuthRepository', () {
    test('returns true when user is signed in', () {
      // Arrange
      when(() => authRemoteDataSource.authUser).thenReturn(
        const AuthUserModel('123', 'test@example.com', 'Test User'),
      );

      // Act
      final result = authRepository.signedIn;

      // Assert
      expect(result, isTrue);
    });

    test('returns false when user is not signed in', () {
      // Arrange
      when(() => authRemoteDataSource.authUser).thenReturn(null);

      // Act
      final result = authRepository.signedIn;

      // Assert
      expect(result, isFalse);
    });
  });
}
