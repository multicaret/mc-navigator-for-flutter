import 'package:mc_navigator/mc_navigator.dart';

final class AppRoutes extends McNavigationRoutes {
  AppRoutes(super.routeSlug, [super.routeDialog]);

  static AppRoutes homeRoute = AppRoutes('home');
  static AppRoutes secondPageRoute = AppRoutes('second-page-route');
  static AppRoutes thirdPageRoute = AppRoutes('third-page-route');
  static AppRoutes maxCounterRoute = AppRoutes('max-counter-route', DialogRouteModel(true, true));
}
