import 'package:ai_chat_app/core/auth/data/auth_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseUser extends Mock implements User {}

void main() {
  group('AuthUserModel', () {
    test('creates AuthUserModel from Firebase User', () {
      // Arrange
      final firebaseUser = MockFirebaseUser();
      when(() => firebaseUser.uid).thenReturn('123');
      when(() => firebaseUser.email).thenReturn('test@example.com');
      when(() => firebaseUser.displayName).thenReturn('Test User');

      // Act
      final userModel = AuthUserModel.fromFirebaseUser(firebaseUser);

      // Assert
      expect(userModel.uid, '123');
      expect(userModel.email, 'test@example.com');
      expect(userModel.name, 'Test User');
    });

    test('creates AuthUserModel from JSON', () {
      // Arrange
      final json = {
        'uid': '123',
        'email': 'test@example.com',
        'name': 'Test User',
      };

      // Act
      final userModel = AuthUserModel.fromJson(json);

      // Assert
      expect(userModel.uid, '123');
      expect(userModel.email, 'test@example.com');
      expect(userModel.name, 'Test User');
    });

    test('converts AuthUserModel to JSON', () {
      // Arrange
      const userModel = AuthUserModel('123', 'test@example.com', 'Test User');

      // Act
      final json = userModel.toJson();

      // Assert
      expect(json['uid'], '123');
      expect(json['email'], 'test@example.com');
      expect(json['name'], 'Test User');
    });

    test('copies AuthUserModel with new values', () {
      // Arrange
      const userModel = AuthUserModel('123', 'test@example.com', 'Test User');

      // Act
      final copiedUserModel = userModel.copyWith(email: 'new@example.com');

      // Assert
      expect(copiedUserModel.uid, '123');
      expect(copiedUserModel.email, 'new@example.com');
      expect(copiedUserModel.name, 'Test User');
    });

    test('copies AuthUserModel with same values', () {
      // Arrange
      const userModel = AuthUserModel('123', 'test@example.com', 'Test User');

      // Act
      final copiedUserModel = userModel.copyWith();

      // Assert
      expect(copiedUserModel.uid, '123');
      expect(copiedUserModel.email, 'test@example.com');
      expect(copiedUserModel.name, 'Test User');
    });
  });
}
