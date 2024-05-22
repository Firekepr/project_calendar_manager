// ignore_for_file: non_constant_identifier_names

import 'package:project_calendar_manager/service/utils/utils.dart';

class EventsC {
  int id;
  String description;
  DateTime date;
  bool favorite;
  int event_order;

  EventsC({
    required this.id,
    required this.description,
    required this.date,
    required this.favorite,
    required this.event_order,
  });

  factory EventsC.fromMap(Map<String, dynamic> map) => EventsC(
    id: map['id'],
    description: map['description'],
    date: DateTime.parse(map['date']),
    favorite: UtilsS.binaryToBool(map['favorite']),
    event_order: map['event_order'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'description': description,
    'date': date,
    'favorite': favorite,
    'event_order': event_order,
  };
}