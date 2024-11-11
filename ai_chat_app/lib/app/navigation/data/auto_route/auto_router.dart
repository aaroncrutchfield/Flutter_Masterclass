import 'package:ai_chat_app/app/navigation/data/auto_route/auto_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

/// The implementation of the RootStackRouter that uses the AutoRouterConfig to
/// generate the routes.
@AutoRouterConfig()
@singleton
class RootAutoRouter extends RootStackRouter {
  RootAutoRouter();

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/counter', page: CounterRoute.page, initial: true),
      ];
}
