import 'package:ai_chat_app/app/di/app/app_injection.dart';
import 'package:ai_chat_app/app/navigation/app_navigation.dart';
import 'package:ai_chat_app/app/navigation/app_navigation_provider.dart';
import 'package:ai_chat_app/counter/counter.dart';
import 'package:ai_chat_app/l10n/l10n.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';


class App extends StatelessWidget {

  App({super.key});

  final _navigation = appRegistry<AppNavigation>();

  @override
  Widget build(BuildContext context) {
    return AppNavigationProvider(
      appNavigation: _navigation,
      child: MaterialApp.router(
        routerConfig: _navigation.routerConfig(),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
