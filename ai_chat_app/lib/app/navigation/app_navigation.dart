import 'package:ai_chat_app/app/navigation/auto_route/auto_router.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// The router for the app.
abstract interface class AppNavigation {
  RouterConfig<Object> routerConfig();

  Future<void> navigateNamed(String name);

  Future<T?> pushNamed<T extends Object?>(String name);

  Future<bool> maybePop<T extends Object?>([T? result]);
}

/// The implementation of the [AppNavigation] that uses the [RootAutoRouter].
@Singleton(as: AppNavigation)
class AutoRouteNavigation implements AppNavigation {
  AutoRouteNavigation(this._router);

  final RootAutoRouter _router;

  @override
  RouterConfig<Object> routerConfig() => _router.config();

  @override
  Future<void> navigateNamed(String name) => _router.navigateNamed(name);

  @override
  Future<T?> pushNamed<T extends Object?>(String name) =>
      _router.pushNamed(name);

  @override
  Future<bool> maybePop<T extends Object?>([T? result]) =>
      _router.maybePop(result);
}
