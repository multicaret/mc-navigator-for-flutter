import 'package:flutter/widgets.dart';
import 'package:mc_navigator/src/interfaces/navigation_actions.dart';
import 'package:mc_navigator/src/interfaces/page_route_contract.dart';
import 'package:mc_navigator/src/mixins/pop_actions.dart';
import 'package:mc_navigator/src/models/mc_page_route.dart';

final class NamedRoutesActions with PopActions implements NavigationActions {
  late final NavigatorState _navigatorState;
  final PageRouteContract _data;
  final ValueChanged<Object?>? _onPop;

  NamedRoutesActions(BuildContext ctx, this._data, [this._onPop, bool isRoot = false])
      : _navigatorState = Navigator.of(ctx, rootNavigator: isRoot);

  @override
  String get route => _data.route.path;

  @override
  NavigatorState get navigatorState => _navigatorState;

  @override
  ValueChanged<Object?>? get onPop => _onPop;

  @override
  Future<T?> push<T extends Object?>() async {
    T? res = await _navigatorState.pushNamed<T>(route, arguments: _data.args);
    _handlePop(res);
    return res;
  }

  @override
  Future<T?> pushAndRemoveUntil<T extends Object?>(McPageRoute pageRoute) async {
    T? res = await _navigatorState.pushNamedAndRemoveUntil<T>(
      route,
      _routePredicate(pageRoute),
      arguments: _data.args,
    );
    // Todo(suheyl): [2024-11-05 - 5_07_a_m_] Test handle pop method
    _handlePop(res);
    return res;
  }

  @override
  Future<T?> pushReplacement<T extends Object?>() async {
    T? res = await _navigatorState.pushReplacementNamed(route, arguments: _data.args);
    _handlePop(res);
    return res;
  }

  RoutePredicate _routePredicate(McPageRoute pageRoute) {
    return (Route route) {
      return route.settings.name == pageRoute.routeSlug;
    };
  }

  void _handlePop(Object? res) {
    if (_onPop != null) _onPop(res);
  }
}
