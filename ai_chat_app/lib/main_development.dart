import 'package:ai_chat_app/app/app.dart';
import 'package:ai_chat_app/app/di/helper/injection.dart';
import 'package:ai_chat_app/app/environments.dart';
import 'package:ai_chat_app/bootstrap.dart';
import 'package:ai_chat_app/firebase/firebase_options_dev.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  bootstrap(
    builder: () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      await appRegistry.init(Environment.development);

      return RepositoryProvider.value(
        value: appRegistry,
        child: const App(),
      );
    },
  );
}
