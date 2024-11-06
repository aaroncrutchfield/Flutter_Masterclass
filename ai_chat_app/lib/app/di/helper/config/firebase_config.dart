import 'package:ai_chat_app/app/di/helper/annotations.dart';
import 'package:ai_chat_app/firebase/firebase_options_dev.dart' as dev;
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

/// The basic settings needed to connect to Firebase.
///
/// Think of this as a template for storing important Firebase connection
/// details like API keys and project IDs. Different environments (development,
/// staging, production) will have their own specific settings.
abstract class FirebaseConfig {
  /// Gets the Firebase connection settings for the current environment.
  ///
  /// These settings tell your app how to connect to the right Firebase project.
  FirebaseOptions get options;
}

/// Firebase settings for development/testing.
///
/// This is used when developers are building and testing the app locally.
/// It connects to a test Firebase project that's safe to experiment with.
///
/// @development means this is only used in development mode
/// @Singleton means only one copy of these settings exists in the app
/// (as: FirebaseConfig) means this is one way to implement FirebaseConfig
@development
@Singleton(as: FirebaseConfig)
class DevFirebaseConfig implements FirebaseConfig {
  @override
  FirebaseOptions get options => dev.DefaultFirebaseOptions.currentPlatform;
}

/// Firebase settings for the staging environment.
///
/// Staging is like a dress rehearsal for production - it's where we test
/// everything in a production-like environment before releasing to real users.
///
/// Note: Currently shows an error because staging settings haven't been set
/// up yet.
@production
@Singleton(as: FirebaseConfig)
class StgFirebaseConfig implements FirebaseConfig {
  @override
  FirebaseOptions get options =>
      throw UnimplementedError('Staging options not implemented');
}

/// Firebase settings for the production environment.
///
/// These are the real settings used when the app is released to users.
/// This connects to the main Firebase project with real user data.
///
/// Note: Currently shows an error because production settings haven't been
/// set up yet.
@production
@Singleton(as: FirebaseConfig)
class ProdFirebaseConfig implements FirebaseConfig {
  @override
  FirebaseOptions get options =>
      throw UnimplementedError('Production options not implemented');
}
