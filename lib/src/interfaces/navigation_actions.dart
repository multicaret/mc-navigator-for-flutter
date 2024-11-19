import 'package:mc_navigator/src/interfaces/type_def.dart';
import 'package:mc_navigator/src/models/mc_page_route.dart';

abstract interface class NavigationActions {
  String get route;

  Future<T?> push<T extends Object?>();

  Future<T?> pushReplacement<T extends Object?>();

  Future<T?> pushAndRemoveUntil<T extends Object?>(McPageRoute pageRoute);

  Future<T?> pushAndRemoveUntilCurrent<T extends Object?>();

  void pop([ValueTransformer<Object?>? result]);

  void popToFirst();

  void popUntil(McPageRoute pageRoute);

  Future<bool> maybePop([ValueTransformer<Object?>? result]);
}
