import 'package:ai_chat_app/core/auth/data/auth_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

/// The remote data source for authentication
abstract interface class AuthRemoteDataSource {
  /// Returns the currently authenticated user
  AuthUserModel? get authUser;
}

@Singleton(as: AuthRemoteDataSource)
class FirebaseAuthDataSource implements AuthRemoteDataSource {
  FirebaseAuthDataSource(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  AuthUserModel? get authUser {
    // Get the current user from Firebase Auth
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;
    return AuthUserModel.fromFirebaseUser(firebaseUser);
  }
}
