import 'package:ai_chat_app/app/di/injection_registry.dart';
import 'package:ai_chat_app/app/view/app.dart';
import 'package:ai_chat_app/features/auth/view/auth_page.dart';
import 'package:ai_chat_app/features/chat/chat.dart';
import 'package:ai_chat_app/features/chat/widget/chat_greeting.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app

@widgetbook.UseCase(name: 'Default', type: ChatPage, path: '[Pages]')
Widget buildChatPage(BuildContext context) => const ChatPage();

@widgetbook.UseCase(name: 'Default', type: ChatGreeting, path: '[Widgets]/Chat')
Widget buildChatGreeting(BuildContext context) => const ChatGreeting();
