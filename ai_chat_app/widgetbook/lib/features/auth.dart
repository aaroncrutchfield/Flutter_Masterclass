import 'package:ai_chat_app/features/auth/view/auth_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: AuthPage, path: '[Pages]')
Widget buildAuthPage(BuildContext context) => const AuthPage();
