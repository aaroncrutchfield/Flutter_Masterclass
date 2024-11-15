import 'package:ai_chat_app/app/navigation/app_navigation.dart';
import 'package:ai_chat_app/core/auth/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._navigation,
    this._authRepository,
  ) : super(AuthInitial()) {
    checkAuthStatus();
  }

  final AppNavigation _navigation;
  final AuthRepository _authRepository;

  void checkAuthStatus() {
    // Check if the user is signed in.
    // If the user is signed in, navigate to the home page.
    // If the user is not signed in, navigate to the sign-in screen.
    if (_authRepository.signedIn) {
      navigateToCounter();
    } else {
      navigateToAuth();
    }
  }

  void navigateToChat() {
    _navigation.replaceNamed('/chat');
  }

  void navigateToCounter() {
    _navigation.replaceNamed('/counter');
  }

  void navigateToAuth() {
    _navigation.replaceNamed('/login');
  }
}
