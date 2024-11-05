import 'package:flutter/cupertino.dart';
import 'package:mc_navigator/src/actions/cupertino_page_routes_actions.dart';
import 'package:mc_navigator/src/actions/named_routes_actions.dart';
import 'package:mc_navigator/src/models/mc_page_route.dart';

import 'actions/material_page_routes_actions.dart';
import 'enums/navigation_type.dart';
import 'interfaces/navigation_actions.dart';
import 'interfaces/page_route_contract.dart';

class NavigatorActions implements NavigationActions {
  static NavigationType _type = NavigationType.main();

  final BuildContext _context;
  final PageRouteContract _routeData;
  late final NavigationActions _actions;

  NavigatorActions._(this._context, PageRouteContract routeData,
      [ValueChanged<Object?>? onPop, bool isRoot = false])
      : _routeData = routeData {
    switch (_type) {
      case NavigationType.materialPageRoute:
        _actions = MaterialPageRoutesActions(_context, routeData, onPop, isRoot);
      case NavigationType.cupertinoPageRoute:
        _actions = CupertinoPageRoutesActions(_context, routeData, onPop, isRoot);
      case NavigationType.namedRoute:
        _actions = NamedRoutesActions(_context, routeData, onPop, isRoot);
    }
  }

  factory NavigatorActions.noneRoot(BuildContext context, PageRouteContract routeData,
      [ValueChanged<Object?>? onPop]) {
    return NavigatorActions._(context, routeData, onPop, false);
  }

  factory NavigatorActions.byRoot(BuildContext context, PageRouteContract routeData,
      [ValueChanged<Object?>? onPop]) {
    return NavigatorActions._(context, routeData, onPop, true);
  }

  static void updateType(NavigationType type) => _type = type;

  @override
  Future<bool> maybePop() => _actions.maybePop();

  @override
  void pop() => _actions.pop();

  @override
  void popToFirst() => _actions.popToFirst();

  @override
  void popUntil(McPageRoute pageRoute) => _actions.popUntil(pageRoute);

  @override
  Future<T?> push<T extends Object?>() {
    return _actions.push();
  }

  @override
  Future<T?> pushAndRemoveUntil<T extends Object?>(McPageRoute pageRoute) {
    return _actions.pushAndRemoveUntil(pageRoute);
  }

  @override
  Future<T?> pushReplacement<T extends Object?>() {
    return _actions.pushReplacement();
  }

  @override
  String get route => _routeData.route.routeSlug;

  static NavigationType getType() => _type;
}
