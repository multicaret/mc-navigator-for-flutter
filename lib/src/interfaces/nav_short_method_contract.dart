import 'package:flutter/widgets.dart';
import 'package:mc_navigator/src/navigator_actions.dart';

abstract class NavShortMethodContract {
  NavigatorActions navBy(BuildContext context, {ValueChanged<dynamic>? onPop});

  NavigatorActions navByToRoot(BuildContext context, {ValueChanged<dynamic>? onPop});
}
