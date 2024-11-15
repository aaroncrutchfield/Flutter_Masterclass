import 'package:firebase_auth/firebase_auth.dart';

/// The model for the authenticated user
///
/// NOTE: Freezed can generate most of the boilerplate code for you but you need
/// to run a script every time you make changes to the model.
///
/// Macros will be better once they are no longer experimental.
class AuthUserModel {
  const AuthUserModel(this.uid, this.email, this.name);

  AuthUserModel.fromFirebaseUser(User user)
      : uid = user.uid,
        email = user.email ?? '',
        name = user.displayName ?? '';

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      json['uid'] as String,
      json['email'] as String,
      json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }

  AuthUserModel copyWith({
    String? uid,
    String? email,
    String? name,
  }) {
    return AuthUserModel(
      uid ?? this.uid,
      email ?? this.email,
      name ?? this.name,
    );
  }

  final String uid;
  final String email;
  final String name;
}
