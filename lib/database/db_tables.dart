class DBTables {

  static List<String> allTables = [ user, events ];

  static const String user = '''
  CREATE TABLE user (
    id integer primary key auto increment,
    name text not null default 'User',
    user_photo text
  )
  ''';

  static const String events = '''
  CREATE TABLE events (
    id integer primary key auto increment,
    description text not null default '',
    date text not null,
    color text not null 'fffffff',
    favorite integer not null default 0,
    user_id integer not null,
    event_order auto increment
  )
  ''';
}