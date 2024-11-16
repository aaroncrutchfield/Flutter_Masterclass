import 'package:ai_chat_app/features/chat/chat.dart';
import 'package:ai_chat_app/features/chat/widget/chat_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app

@widgetbook.UseCase(name: 'Default', type: ChatPage, path: '[Pages]')
Widget buildChatPage(BuildContext context) => const ChatPage();

@widgetbook.UseCase(name: 'Default', type: ChatAppBar, path: '[Widgets]/Chat')
Widget buildChatAppBar(BuildContext context) => const ChatAppBar();

@widgetbook.UseCase(name: 'Default', type: ChatGreeting, path: '[Widgets]/Chat')
Widget buildChatGreeting(BuildContext context) => const ChatGreeting();

@widgetbook.UseCase(name: 'Default', type: ChatInput, path: '[Widgets]/Chat')
Widget buildChatInput(BuildContext context) => const ChatInput();

@widgetbook.UseCase(name: 'Default', type: FileInputSection, path: '[Widgets]/Chat')
Widget buildFileInput(BuildContext context) => const FileInputSection();
