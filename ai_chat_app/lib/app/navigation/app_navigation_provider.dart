import 'package:ai_chat_app/app/navigation/app_navigation.dart';
import 'package:flutter/material.dart';

class AppNavigationProvider extends InheritedWidget {

  const AppNavigationProvider({
    required this.appNavigation, required super.child, super.key,
  });
  final AppNavigation appNavigation;

  static AppNavigationProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppNavigationProvider>();
  }

  @override
  bool updateShouldNotify(AppNavigationProvider oldWidget) {
    return appNavigation != oldWidget.appNavigation;
  }
}

extension AppNavigationX on BuildContext  {
  AppNavigation get _appNavigation {
    final appRouterProvider = AppNavigationProvider.of(this);
    return appRouterProvider!.appNavigation;
  }

  Future<void> navigateNamed(String name) => _appNavigation.navigateNamed(name);

  Future<T?> pushNamed<T extends Object?>(String name) => _appNavigation.pushNamed(name);

  Future<bool> maybePop<T extends Object?>([T? result]) => _appNavigation.maybePop(result);


}