import 'package:ai_chat_app/app/di/injection_registry.dart';
import 'package:ai_chat_app/features/auth/cubit/auth_cubit.dart';
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

class MockAuthCubit extends Mock implements AuthCubit {}

void main() {
  group('AuthPage', () {
    late FirebaseAuth mockFirebaseAuth;
    late AuthCubit mockAuthCubit;

    setUp(() {
      setFirebaseUiIsTestMode(true);
      mockFirebaseAuth = MockFirebaseAuth();
      mockAuthCubit = MockAuthCubit();

      when(() => mockFirebaseAuth.app).thenReturn(MockFirebaseApp());
      when(() => mockAuthCubit.state).thenReturn(AuthInitial());
      when(() => mockAuthCubit.stream)
          .thenAnswer((_) => Stream.value(AuthInitial()));
      when(() => mockAuthCubit.close())
          .thenAnswer((_) => Future.value());

      appRegistry
        ..register(() => mockFirebaseAuth)
        ..register(() => mockAuthCubit);
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
