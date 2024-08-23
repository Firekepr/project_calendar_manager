// ignore_for_file: non_constant_identifier_names

import 'package:project_calendar_manager/service/utils/utils.dart';

class EventsC {
  int id;
  String description;
  String color;
  DateTime date;
  bool favorite;
  int event_order;

  EventsC({
    required this.id,
    required this.description,
    required this.color,
    required this.date,
    required this.favorite,
    required this.event_order,
  });

  factory EventsC.fromMap(Map<String, dynamic> map) => EventsC(
    id: map['id'],
    description: map['description'],
    color: map['color'],
    date: DateTime.parse(map['date']),
    favorite: UtilsS.binaryToBool(map['favorite']),
    event_order: map['event_order'],
  );

  Map<String, dynamic> toMap({bool trash = false}) {
    Map<String, dynamic> map = {
      'id': id,
      'description': description,
      'color': color,
      'date': date.toString().substring(0, 10),
      'favorite': UtilsS.boolToBinary(favorite),
      'event_order': event_order,
    };

    if (trash) map['trash'] =UtilsS.boolToBinary(trash);

    return map;
  }
}


class EventsDots {
  int count;
  String color;

  EventsDots({
    required this.count,
    required this.color,
  });

  factory EventsDots.fromMap(Map<String, dynamic> map) => EventsDots(
    count: map['count'],
    color: map['color'],
  );
}