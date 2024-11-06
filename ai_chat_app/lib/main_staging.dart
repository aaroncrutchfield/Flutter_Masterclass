import 'package:ai_chat_app/app/app.dart';
import 'package:ai_chat_app/app/di/helper/injection.dart';
import 'package:ai_chat_app/app/environments.dart';
import 'package:ai_chat_app/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  bootstrap(
    builder: () async {
      WidgetsFlutterBinding.ensureInitialized();
      await appRegistry.init(Environment.staging);

      return RepositoryProvider.value(
        value: appRegistry,
        child: const App(),
      );
    },
  );
}
