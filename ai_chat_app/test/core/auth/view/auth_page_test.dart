import 'package:ai_chat_app/app/di/injection_registry.dart';
import 'package:ai_chat_app/features/auth/view/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

class MockFirebaseApp extends Mock implements FirebaseApp {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  group('AuthPage', () {
    late FirebaseAuth mockFirebaseAuth;

    setUp(() {
      setFirebaseUiIsTestMode(true);
      mockFirebaseAuth = MockFirebaseAuth();
      when(() => mockFirebaseAuth.app).thenReturn(MockFirebaseApp());
      appRegistry.register(() => mockFirebaseAuth);
    });

    tearDown(appRegistry.reset);

    testWidgets('renders AuthPage', (tester) async {
      await tester.pumpApp(const AuthPage());

      expect(find.byType(AuthPage), findsOneWidget);
    });

    testWidgets('renders SignInScreen', (tester) async {
      await tester.pumpApp(const AuthPage());

      expect(find.byType(SignInScreen), findsOneWidget);
    });

    testWidgets('renders SignInScreen', (tester) async {
      await tester.pumpApp(const AuthPage());

      expect(find.byType(SignInScreen), findsOneWidget);
    });
  });
}
