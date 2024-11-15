import 'package:ai_chat_app/core/auth/data/auth_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

void main() {
  late FirebaseAuth firebaseAuth;
  late AuthRemoteDataSource dataSource;

  setUp(() {
    firebaseAuth = MockFirebaseAuth();
    dataSource = FirebaseAuthDataSource(firebaseAuth);
  });

  group('FirebaseAuthDataSource', () {
    test('returns null when there is no authenticated user', () {
      // Arrange
      when(() => firebaseAuth.currentUser).thenReturn(null);

      // Act
      final result = dataSource.authUser;

      // Assert
      expect(result, isNull);
    });

    test('returns AuthUserModel when there is an authenticated user', () {
      // Arrange
      final mockUser = MockUser();
      when(() => firebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('123');
      when(() => mockUser.email).thenReturn('test@example.com');

      // Act
      final result = dataSource.authUser;

      // Assert
      expect(result, isNotNull);
      expect(result!.uid, '123');
      expect(result.email, 'test@example.com');
    });
  });
}
