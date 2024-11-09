import 'package:ai_chat_app/app/app.dart';
import 'package:ai_chat_app/app/di/domain/injection_registry.dart';
import 'package:ai_chat_app/app/environments.dart';
import 'package:ai_chat_app/bootstrap.dart';
import 'package:flutter/material.dart';

void main() {
  bootstrap(
    builder: () async {
      WidgetsFlutterBinding.ensureInitialized();
      await appRegistry.init(Environment.staging);

      return const App();
    },
  );
}
