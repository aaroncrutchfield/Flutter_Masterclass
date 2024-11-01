import 'package:ai_chat_app/firebase/firebase_options_dev.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<FirebaseApp> get firebase => Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @singleton
  FirebaseUIAuth get firebaseUIAuth {
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);
    return FirebaseUIAuth();
  }

  @Singleton()
  auth.FirebaseAuth get firebaseAuth => auth.FirebaseAuth.instance;
}
