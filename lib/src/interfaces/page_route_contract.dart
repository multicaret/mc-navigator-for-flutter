import 'package:flutter/cupertino.dart';
import 'package:mc_navigator/mc_navigator.dart';

abstract interface class PageRouteContract {
  McNavigationRoutes get route;

  Widget get getWidget;
}
