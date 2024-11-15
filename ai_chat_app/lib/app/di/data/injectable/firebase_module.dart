// coverage:ignore-file

import 'package:ai_chat_app/app/di/data/injectable/annotations.dart';
import 'package:ai_chat_app/firebase/firebase_options_dev.dart' as dev;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:injectable/injectable.dart';

/// Module that provides Firebase-related dependencies with
/// environment-specific configurations.
///
/// This module is ignored for code coverage purposes.
@module
abstract class FirebaseModule {
  /// Provides Firebase options for the development environment.
  @development
  @singleton
  FirebaseOptions getDevOptions() => dev.DefaultFirebaseOptions.currentPlatform;

  /// Provides Firebase options for the staging environment.
  ///
  /// Currently unimplemented and throws [UnimplementedError].
  @staging
  @singleton
  FirebaseOptions getStgOptions() =>
      throw UnimplementedError('Staging options not implemented');

  /// Provides Firebase options for the production environment.
  ///
  /// Currently unimplemented and throws [UnimplementedError].
  @production
  @singleton
  FirebaseOptions getProdOptions() =>
      throw UnimplementedError('Production options not implemented');

  /// Initializes Firebase with the provided options.
  ///
  /// Used across all environments (development, staging, production).
  @development
  @staging
  @production
  @preResolve
  Future<FirebaseApp> getFirebase(FirebaseOptions options) =>
      Firebase.initializeApp(options: options);

  /// Configures and provides FirebaseUIAuth instance.
  ///
  /// Sets up email authentication provider for the given Firebase app.
  @singleton
  FirebaseUIAuth getFirebaseUIAuth(FirebaseApp app) {
    FirebaseUIAuth.configureProviders([EmailAuthProvider()], app: app);
    return FirebaseUIAuth();
  }

  /// Provides Firebase Authentication instance for the given Firebase app.
  @singleton
  auth.FirebaseAuth getFirebaseAuth(FirebaseApp app) =>
      auth.FirebaseAuth.instanceFor(app: app);
}
