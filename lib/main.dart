import 'package:flutter/material.dart';
import 'package:project_calendar_manager/pages/app/app.dart';
import 'package:project_calendar_manager/providers/calendar_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [ ChangeNotifierProvider<CalendarProvider>(create: (_) => CalendarProvider()) ],
        child: const MyApp(),
      ),
  );
}
