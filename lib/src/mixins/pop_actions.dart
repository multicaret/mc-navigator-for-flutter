import 'package:flutter/widgets.dart';
import 'package:mc_navigator/src/interfaces/type_def.dart';
import 'package:mc_navigator/src/models/mc_page_route.dart';

mixin PopActions {
  NavigatorState get navigatorState;

  void pop([ValueTransformer<Object?>? result]) =>
      navigatorState.pop<ValueTransformer<Object?>?>(result);

  void popToFirst() => navigatorState.popUntil((Route r) => r.isFirst);

  void popUntil(McPageRoute pageRoute) => navigatorState.popUntil(_routePredicate(pageRoute));

  Future<bool> maybePop([ValueTransformer<Object?>? result]) =>
      navigatorState.maybePop<ValueTransformer<Object?>?>(result);

  RoutePredicate _routePredicate(McPageRoute pageRoute) {
    return (Route route) {
      return route.settings.name == pageRoute.routeSlug;
    };
  }
}
