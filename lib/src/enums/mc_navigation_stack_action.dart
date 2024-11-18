import 'package:navigation_history_observer/navigation_history_observer.dart';

enum McNavigationStackAction {
  push(NavigationStackAction.push),
  pop(NavigationStackAction.pop),
  remove(NavigationStackAction.remove),
  replace(NavigationStackAction.replace),
  ;

  final NavigationStackAction action;

  const McNavigationStackAction(this.action);

  static McNavigationStackAction? fromOriginal(NavigationStackAction? enumCase) {
    if (enumCase == null) return null;
    return _findByAction(enumCase);
  }

  static McNavigationStackAction _findByAction(NavigationStackAction enumCase) {
    return McNavigationStackAction.values
        .firstWhere((McNavigationStackAction action) => action.action == enumCase);
  }
}
