library;

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:mc_navigator/src/interfaces/page_route_contract.dart';
import 'package:mc_navigator/src/navigator_actions.dart';

import 'src/enums/navigation_type.dart';
import 'src/interfaces/nav_short_method_contract.dart';
import 'src/models/mc_page_route.dart';

export 'src/models/dialog_route_model.dart';
export 'src/models/mc_history_change.dart';
export 'src/services/mc_navigation_history.dart';

final class NavigatorInitializer {
  NavigatorInitializer._(NavigationType type) {
    NavigatorActions.updateType(type);
  }

  factory NavigatorInitializer.setMaterial() =>
      NavigatorInitializer._(NavigationType.materialPageRoute);

  factory NavigatorInitializer.setCupertino() =>
      NavigatorInitializer._(NavigationType.cupertinoPageRoute);

  factory NavigatorInitializer.setNamedRoute() => NavigatorInitializer._(NavigationType.namedRoute);

  factory NavigatorInitializer.byOs() {
    if (Platform.isIOS) {
      return NavigatorInitializer._(NavigationType.cupertinoPageRoute);
    }
    return NavigatorInitializer._(NavigationType.materialPageRoute);
  }
}

mixin NavMixin implements NavShortMethodContract, PageRouteContract {
  @override
  NavigatorActions navBy(BuildContext context, {ValueChanged<dynamic>? onPop}) {
    return NavigatorActions.byRoot(context, this, onPop);
  }

  @override
  NavigatorActions navByToRoot(BuildContext context, {ValueChanged<dynamic>? onPop}) {
    return NavigatorActions.noneRoot(context, this, onPop);
  }
}

base class McNavigationRoutes extends McPageRoute {
  const McNavigationRoutes(super.routeSlug, [super.routeDialog, super.args]);

  McNavigationRoutes withArguments([Map<String, String?> args = const {}]) {
    return McNavigationRoutes(routeSlug, routeDialog, args);
  }

  static Map<String, WidgetBuilder> buildRouteList(List<PageRouteContract> pages) {
    return Map.fromEntries(pages.map((PageRouteContract e) {
      return MapEntry(e.route.path, (BuildContext ctx) => e.getWidget);
    }));
  }
}

extension ExtensionContextPop on BuildContext {
  void pop<E>([E? result]) {
    Navigator.of(this).pop<E>(result);
  }
}
