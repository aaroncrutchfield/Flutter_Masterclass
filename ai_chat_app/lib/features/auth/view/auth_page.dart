import 'package:ai_chat_app/app/di/injection_registry.dart';
import 'package:ai_chat_app/features/auth/cubit/auth_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AuthPage extends StatelessWidget {
  const AuthPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => appRegistry.get<AuthCubit>(),
      child: const AuthView(),
    );
  }
}

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return SignInScreen(
      auth: appRegistry<FirebaseAuth>(),
      actions: [
        // Executes the onSignedIn callback when the user signs in.
        AuthStateChangeAction<SignedIn>(
          (ctx, state) {
            cubit.navigateToCounter();
            // Navigate to the home page after the user signs in.
          },
        ),
        // Executes the onSignedOut callback when the user signs out.
        SignedOutAction((ctx) {
          cubit.navigateToAuth();
          // Navigate to the sign-in screen after the user signs out.
        }),
      ],
    );
  }
}
