import 'package:ai_chat_app/core/auth/data/auth_remote_data_source.dart';
import 'package:injectable/injectable.dart';

abstract interface class AuthRepository {
  bool get signedIn;
}

@Singleton(as: AuthRepository)
class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._authRemoteDataSource);

  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  bool get signedIn => _authRemoteDataSource.authUser != null;
}
