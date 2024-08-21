import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Global {
  static bool isDev = kDebugMode;

  static bool printSelectQuery = true;
  static bool printInsertQuery = true;
  static bool printUpdateQuery = true;
  static bool printDeleteQuery = true;

  static DateTime selectedDay = DateTime.now();
  static Locale currentLanguage = const Locale('en', '');
}