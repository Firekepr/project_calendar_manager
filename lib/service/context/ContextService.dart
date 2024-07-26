import 'package:flutter/material.dart';

class ContextService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  static BuildContext get context => navigatorKey.currentContext!;
}