// coverage:ignore-file

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:injectable/injectable.dart';

/// The main setup class for important app services.
///
/// This class is like a startup checklist for your app. It sets up:
/// - Firebase connection
/// - User authentication (login/signup)
/// - Other core services the app needs
///
/// @module tells the app this class provides important pieces we'll need later
@module
abstract class AppModule {
  /// Starts up Firebase with the right settings.
  ///
  /// This is marked with @preResolve because we need Firebase running
  /// before we can do anything else with it. It's like making sure
  /// the engine is running before trying to drive the car.
  ///
  /// Returns a FirebaseApp once everything is ready to use.
  // @Singleton(order: 1)
  // Future<FirebaseApp> getFirebase(FirebaseConfig config) =>
  //     Firebase.initializeApp(options: config.options);

  /// Sets up the login/signup screens and features.
  ///
  /// This creates a FirebaseUIAuth object that handles:
  /// - Email/password login
  /// - Login screens
  /// - Account management
  ///
  /// @singleton means we only create one copy of this for the whole app
  /// (which saves memory and keeps things organized)
  @Singleton()
  FirebaseUIAuth get firebaseUIAuth {
    // Tell Firebase what ways users can log in
    // Right now we only allow email/password login
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);
    return FirebaseUIAuth();
  }

  /// Gets the main Firebase authentication service.
  ///
  /// This handles all the behind-the-scenes work of:
  /// - Keeping track of logged-in users
  /// - Handling login/logout
  /// - Managing user sessions
  ///
  /// @Singleton() means we use the same instance everywhere in the app
  /// to keep track of the user's login state
  @Singleton()
  auth.FirebaseAuth get firebaseAuth => auth.FirebaseAuth.instance;
}
