import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mc_navigator/src/interfaces/navigation_actions.dart';
import 'package:mc_navigator/src/interfaces/page_route_contract.dart';
import 'package:mc_navigator/src/mixins/pop_actions.dart';
import 'package:mc_navigator/src/models/mc_page_route.dart';

final class MaterialPageRoutesActions with PopActions implements NavigationActions {
  late final NavigatorState _navigatorState;
  final PageRouteContract _data;
  final ValueChanged<Object?>? _onPop;

  MaterialPageRoutesActions(BuildContext ctx, this._data, [this._onPop, bool isRoot = false])
      : _navigatorState = Navigator.of(ctx, rootNavigator: isRoot);

  @override
  String get route => _data.route.routeSlug;

  @override
  NavigatorState get navigatorState => _navigatorState;

  @override
  Future<T?> push<T extends Object?>() async {
    T? res = await _navigatorState.push<T>(_newRoute<T>());
    _handlePop(res);
    return res;
  }

  @override
  Future<T?> pushAndRemoveUntil<T extends Object?>(McPageRoute pageRoute) async {
    Route<T> newRoute = _newRoute<T>();
    RoutePredicate predicate = _routePredicate(pageRoute);

    T? res = await _navigatorState.pushAndRemoveUntil<T>(newRoute, predicate);
    _handlePop(res);
    return res;
  }

  @override
  Future<T?> pushAndRemoveUntilCurrent<T extends Object?>() async {
    Route<T> newRoute = _newRoute<T>();
    RoutePredicate predicate = _routePredicate(_data.route);

    T? res = await _navigatorState.pushAndRemoveUntil<T>(newRoute, predicate);
    _handlePop(res);
    return res;
  }

  @override
  Future<T?> pushReplacement<T extends Object?>() async {
    Route<T> newRoute = _newRoute<T>();

    T? res = await _navigatorState.pushReplacement<T, void>(newRoute);
    _handlePop(res);
    return res;
  }

  RoutePredicate _routePredicate(McPageRoute pageRoute) {
    return (Route route) {
      return route.settings.name == pageRoute.routeSlug;
    };
  }

  Route<T> _newRoute<T>() {
    return MaterialPageRoute<T>(
      settings: RouteSettings(name: _data.route.routeSlug, arguments: _data.route.args),
      fullscreenDialog: _data.route.isFullscreenDialog,
      barrierDismissible: _data.route.isDismissible,
      builder: (BuildContext context) {
        return _data.getWidget;
      },
    );
  }

  void _handlePop(Object? res) {
    if (_onPop != null) _onPop(res);
  }
}
