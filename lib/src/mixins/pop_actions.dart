import 'package:flutter/widgets.dart';
import 'package:mc_navigator/src/models/mc_page_route.dart';

mixin PopActions {
  ValueChanged<Object?>? get onPop;

  NavigatorState get navigatorState;

  void pop() => navigatorState.pop<ValueChanged<Object?>?>(onPop);

  void popToFirst() => navigatorState.popUntil((Route r) => r.isFirst);

  void popUntil(McPageRoute pageRoute) => navigatorState.popUntil(_routePredicate(pageRoute));

  Future<bool> maybePop() => navigatorState.maybePop<ValueChanged<Object?>?>(onPop);

  RoutePredicate _routePredicate(McPageRoute pageRoute) {
    return (Route route) {
      return route.settings.name == pageRoute.routeSlug;
    };
  }
}
