import 'package:flutter/widgets.dart';
import 'package:mc_navigator/src/enums/mc_navigation_stack_action.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

class McHistoryChange extends HistoryChange {
  McHistoryChange._({
    super.action,
    super.newRoute,
    super.oldRoute,
  });

  String? get actionName => McNavigationStackAction.fromOriginal(action)?.name;

  String? get newRouteName => newRoute?.settings.name;

  String? get oldRouteName => oldRoute?.settings.name;

  factory McHistoryChange({
    McNavigationStackAction? action,
    Route<dynamic>? newRoute,
    Route<dynamic>? oldRoute,
  }) {
    return McHistoryChange._(
      action: action?.action,
      newRoute: newRoute,
      oldRoute: oldRoute,
    );
  }
}
