import 'dart:async';
import 'dart:developer';

import 'package:{{project_name.snakeCase()}}/app/di/injection_registry.dart';
import 'package:{{project_name.snakeCase()}}/app/environments.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent(${bloc.runtimeType}, $event)');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap({
  required Environment environment,
  required FutureOr<Widget> Function() builder,
}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  WidgetsFlutterBinding.ensureInitialized();

  // Enable Edge-to-Edge on Android 10+
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Set the status bar icon color to white
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // Setting a transparent navigation bar color
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: true,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  usePathUrlStrategy();

  await appRegistry.init(environment);
  Bloc.observer = const AppBlocObserver();

  runApp(await builder());
}
