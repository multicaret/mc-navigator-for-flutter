import 'package:flutter/cupertino.dart';
import 'package:mc_navigator/mc_navigator.dart';

abstract interface class PageRouteContract {
  McNavigationRoutes get route;

  Map<String, String?> get args;

  Widget get getWidget;
}
