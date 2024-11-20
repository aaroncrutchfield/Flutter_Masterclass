import 'package:{{project_name.snakeCase()}}/app/di/injection_registry.dart';
import 'package:{{project_name.snakeCase()}}/app/navigation/app_navigation.dart';
import 'package:{{project_name.snakeCase()}}/l10n/arb/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: appRegistry<AppNavigation>(),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final navigation = context.read<AppNavigation>();
    final colorScheme = ColorScheme.fromSeed(
      brightness: MediaQuery.platformBrightnessOf(context),
      seedColor: Colors.blue,
    );

    return MaterialApp.router(
      routerConfig: navigation.routerConfig(),
      theme: ThemeData(
        colorScheme: colorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
