import 'package:ai_chat_app/app/navigation/app_navigation.dart';
import 'package:ai_chat_app/core/auth/view/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNavigationProvider extends InheritedWidget {
  final AppNavigation appNavigation;

  const AppNavigationProvider({
    Key? key,
    required this.appNavigation,
    required Widget child,
  }) : super(key: key, child: child);

  static AppNavigationProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppNavigationProvider>();
  }

  @override
  bool updateShouldNotify(AppNavigationProvider oldWidget) {
    return appNavigation != oldWidget.appNavigation;
  }
}

extension AppNavigationX on BuildContext  {
  AppNavigation get _appRouter {
    final appRouterProvider = AppNavigationProvider.of(this);
    return appRouterProvider!.appNavigation;
  }

  Future<void> navigateNamed(String name) => _appRouter.navigateNamed(name);

  Future<T?> pushNamed<T extends Object?>(String name) => _appRouter.pushNamed(name);

  Future<bool> maybePop<T extends Object?>([T? result]) => _appRouter.maybePop(result);


}