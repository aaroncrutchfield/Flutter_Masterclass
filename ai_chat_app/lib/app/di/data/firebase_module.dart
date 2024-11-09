// coverage:ignore-file

import 'package:ai_chat_app/app/di/data/config/firebase_config.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:injectable/injectable.dart';

/// The setup class for firebase app services.
///
/// @module tells the app this class provides important pieces that we define
/// ourselves
@module
abstract class FirebaseModule {
  /// Starts up Firebase with the right settings.
  ///
  /// [FirebaseConfig] is a class that holds the settings for Firebase
  /// based on the environment (development, staging, production).
  ///
  /// This is marked with @preResolve because we need Firebase initialized
  /// before we can use it in other parts of the app.
  @preResolve
  Future<FirebaseApp> getFirebase(FirebaseConfig config) =>
      Firebase.initializeApp(options: config.options);

  /// Sets up the Firebase login/signup screens and features.
  ///
  /// @singleton means we only create one copy of this for the whole app
  @singleton
  FirebaseUIAuth getFirebaseUIAuth(FirebaseApp app) {
    FirebaseUIAuth.configureProviders([EmailAuthProvider()], app: app);
    return FirebaseUIAuth();
  }

  /// Gets the main Firebase authentication service.
  ///
  /// @singleton means we only create one copy of this for the whole app
  @singleton
  auth.FirebaseAuth getFirebaseAuth(FirebaseApp app) =>
      auth.FirebaseAuth.instanceFor(app: app);
}
