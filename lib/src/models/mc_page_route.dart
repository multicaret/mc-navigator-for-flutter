import 'package:flutter/widgets.dart';
import 'package:mc_navigator/src/enums/navigation_type.dart';
import 'package:mc_navigator/src/navigator_actions.dart';
import 'package:recase/recase.dart';

import 'dialog_route_model.dart';

base class McPageRoute {
  final String _routeSlug;
  final DialogRouteModel? routeDialog;

  const McPageRoute(String routeSlug, [this.routeDialog]) : _routeSlug = routeSlug;

  String get routeSlug => _routeSlug;

  String get title => _routeSlug.titleCase;

  String get path => '/$_routeSlug';

  RouteSettings get routeSettings {
    NavigationType type = NavigatorActions.getType();
    if (type.isNamedRoute) {
      return RouteSettings(name: path);
    }
    return RouteSettings(name: routeSlug);
  }

  bool get isFullscreenDialog => routeDialog?.isFullscreenDialog ?? false;

  bool get isDismissible => routeDialog?.isDismissible ?? false;

  static McPageRoute root = McPageRoute('/');
}
