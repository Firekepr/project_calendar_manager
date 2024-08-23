import 'package:flutter/material.dart';
import 'package:project_calendar_manager/pages/calendar/calendar_screen.dart';
import 'package:project_calendar_manager/pages/home/components/drawer.dart';
import 'package:project_calendar_manager/providers/calendar_provider.dart';
import 'package:project_calendar_manager/service/calendar/calendar_service.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _service = CalendarS();

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarProvider>(
      builder: (context, CalendarProvider p, Widget? body) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          drawer: const AppDrawer(),
          body: const CalendarScreen(),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _service.newEvent(context),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}