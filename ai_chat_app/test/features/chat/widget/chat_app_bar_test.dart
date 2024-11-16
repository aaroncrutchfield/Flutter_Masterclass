import 'package:ai_chat_app/app/di/injection_registry.dart';
import 'package:ai_chat_app/features/chat/bloc/chat_bloc.dart';
import 'package:ai_chat_app/features/chat/widget/chat_app_bar.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

class MockChatBloc extends MockBloc<ChatEvent, ChatState> implements ChatBloc {}

void main() {
  late ChatBloc mockChatBloc;

  setUp(() {
    mockChatBloc = MockChatBloc();

    appRegistry.register<ChatBloc>(() => mockChatBloc);
  });

  tearDown(appRegistry.reset);

  Widget createWidgetUnderTest(Widget child) {
    return BlocProvider<ChatBloc>.value(
      value: mockChatBloc,
      child: child,
    );
  }

  group('ChatAppBar', () {
    testWidgets('renders correctly with all components', (tester) async {
      await tester.pumpApp(createWidgetUnderTest(const ChatAppBar()));

      expect(find.byType(ChatBackButton), findsOneWidget);
      expect(find.byType(ChatTitle), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('has correct preferred size', (tester) async {
      const chatAppBar = ChatAppBar();
      expect(chatAppBar.preferredSize, const Size.fromHeight(64));
    });
  });

  group('ChatTitle', () {
    testWidgets('displays model selection button with correct text',
        (tester) async {
      await tester.pumpApp(createWidgetUnderTest(const ChatTitle()));

      expect(find.text('Claude 3.5 Sonnet'), findsOneWidget);
      expect(find.byIcon(Icons.expand_more), findsOneWidget);
    });

    testWidgets('displays project selection button with correct text',
        (tester) async {
      await tester.pumpApp(createWidgetUnderTest(const ChatTitle()));

      expect(find.text('Choose project'), findsOneWidget);
      expect(find.byIcon(Icons.category_outlined), findsOneWidget);
    });

    testWidgets('triggers ChooseModel event when model button is pressed',
        (tester) async {
      await tester.pumpApp(createWidgetUnderTest(const ChatTitle()));

      await tester.tap(find.text('Claude 3.5 Sonnet'));
      await tester.pump();

      verify(() => mockChatBloc.add(const ChooseModel())).called(1);
    });

    testWidgets('triggers ChooseProject event when project button is pressed',
        (tester) async {
      await tester.pumpApp(createWidgetUnderTest(const ChatTitle()));

      await tester.tap(find.text('Choose project'));
      await tester.pump();

      verify(() => mockChatBloc.add(const ChooseProject())).called(1);
    });
  });

  group('ChatBackButton', () {
    testWidgets('renders correctly with icon and text', (tester) async {
      await tester.pumpApp(createWidgetUnderTest(const ChatBackButton()));

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.text('Chats'), findsOneWidget);
    });

    testWidgets('has correct coral color', (tester) async {
      await tester.pumpApp(createWidgetUnderTest(const ChatBackButton()));

      final icon = tester.widget<Icon>(find.byIcon(Icons.arrow_back));
      expect(icon.color, const Color(0xFFF0997D));
    });

    testWidgets('triggers NavigateBack event when pressed', (tester) async {
      await tester.pumpApp(createWidgetUnderTest(const ChatBackButton()));

      await tester.tap(find.byType(Text));
      await tester.pump();

      verify(() => mockChatBloc.add(const NavigateBack())).called(1);
    });
  });
}
