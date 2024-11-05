import 'package:mc_navigator/src/models/mc_page_route.dart';

abstract interface class NavigationActions {
  String get route;

  Future<T?> push<T extends Object?>();

  Future<T?> pushReplacement<T extends Object?>();

  Future<T?> pushAndRemoveUntil<T extends Object?>(McPageRoute pageRoute);

  void pop();

  void popToFirst();

  void popUntil(McPageRoute pageRoute);

  Future<bool> maybePop();

  /// => for NamedRoute popAndPushNamed
}
