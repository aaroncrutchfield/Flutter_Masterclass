import 'package:ai_chat_app/app/navigation/data/auto_route/auto_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

/// Root router configuration for the application using AutoRoute.
///
/// This class defines the main routing configuration and navigation behavior
/// for the entire application.
@AutoRouterConfig()
@singleton
class RootAutoRouter extends RootStackRouter {
  /// Creates a new instance of [RootAutoRouter].
  RootAutoRouter();

  /// Defines the default route type for all routes in the application.
  ///
  /// Uses an adaptive route type that adjusts based on the platform.
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  /// Defines all available routes in the application.
  ///
  /// Routes are configured with their respective paths and pages
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/login', page: AuthRoute.page, initial: true),
        AutoRoute(path: '/counter', page: CounterRoute.page),
        AutoRoute(path: '/chat', page: ChatRoute.page),
      ];
}
