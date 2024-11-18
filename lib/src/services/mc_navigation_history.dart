import 'dart:async';

import 'package:mc_navigator/src/enums/mc_navigation_stack_action.dart';
import 'package:mc_navigator/src/interfaces/type_def.dart';
import 'package:mc_navigator/src/models/mc_history_change.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

final class McNavigationHistory {
  final McNavigationHistoryObserver _navigationHistoryObserver = McNavigationHistoryObserver();

  McNavigationHistory._internal();

  factory McNavigationHistory() {
    return McNavigationHistory._internal();
  }

  McNavigationHistoryObserver get observer => _navigationHistoryObserver;

  Stream<McHistoryChange> historyChangeStream() {
    return _navigationHistoryObserver.historyChangeStream
        .transform(StreamTransformer<dynamic, McHistoryChange>.fromHandlers(
      handleData: (dynamic data, EventSink<HistoryChange> sink) {
        if (data is HistoryChange) {
          sink.add(McHistoryChange(
            action: McNavigationStackAction.fromOriginal(data.action),
            oldRoute: data.oldRoute,
            newRoute: data.newRoute,
          ));
        }
      },
    ));
  }
}
