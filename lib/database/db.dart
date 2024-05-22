import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:project_calendar_manager/database/db_tables.dart';
import 'package:project_calendar_manager/enums/db.dart';
import 'package:project_calendar_manager/service/global.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBApp {
  DBApp._privateConstructor();
  static final DBApp instance = DBApp._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ?? await _initialize();

  Future<Database> _initialize() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'spincare.db');

    return await openDatabase(
      path,
      version: 1,
      readOnly: false,
      onCreate: _onCreate,
      onUpgrade: onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      for (String table in DBTables.allTables) {
        db.execute(table);
      }
    } catch (e) {
      if (Global.isDev) log('\n!Error on create tables!\nError: ${e.toString()}');
    }
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future<Database> _get() async => _database ?? await database;

  /// @Database
  ///
  /// How works:
  /// ---
  /// This function selects the elements from the table, the returned is the list of maps with the elements.
  ///```
  /// ATTENTION: In joins query, you can use the alias 't1' to refer to the main table.
  /// ```
  /// RETURNS: List<Map<String, dynamic>> or empty list [].
  /// ```
  Future<List<Map<String, dynamic>>> dbSelect({required TABLES table, String returned = '*', String where = '', String joins = '', int limit = 0, String orderBy = '', String groupBy = ''}) async {
    final db = await _get();

    try {
      final sql = '''
        SELECT $returned
        FROM ${table.name} t1
        $joins
        ${where.isNotEmpty ? 'WHERE $where' : ''}
        ${groupBy.isNotEmpty ? 'group by $groupBy' : ''}
        ${orderBy.isNotEmpty ? 'order by $orderBy' : ''}
        ${limit > 0 ? ' LIMIT $limit' : ''}        
      ''';

      if (Global.printSelectQuery) log('QUERY: $sql');

      final result = await db.rawQuery(sql);

      if (Global.printSelectQuery) log('RETURN: ${result.length} ELEMENTS\n');

      return result;

    } catch (e) {
      if (Global.isDev) log("ERROR ON EXECUTE A SELECT, ERROR: ${e.toString()}");
      return [];
    }
  }

  /// @Database
  ///
  /// ---
  /// How works:
  ///
  /// This function adds the map to the informed table, this function returns the id of the inserted object.
  ///
  /// ---
  /// RETURNS:
  ///
  /// The return is the id of the inserted object. If the return is 0, the insertion was not successful.
  Future<int> dbInsert({required TABLES table, required Map<String, Object?> values}) async {
    final db = await _get();

    final id = await db.insert(table.name, values);

    if (Global.printInsertQuery && id == 0) log('Error inserting in table ${table.name}');

    return id;
  }

  /// @Database
  ///
  /// ---
  /// How works:
  ///
  /// This function updates the table with the values informed in the map, the where and whereArgs are used to identify the element to be updated.
  ///
  /// ---
  /// Return:
  ///
  /// The return is the number of rows affected by the update.
  Future<int> dbUpdate({required TABLES table, required Map<String, Object?> values, required String where, required var whereArgs}) async {
    final db = await _get();

    final count = await db.update(table.name, values, where: where, whereArgs: [whereArgs]);

    if (Global.printUpdateQuery && count == 0) log('Error updating in table ${table.name}');

    return count;
  }

  /// @Database
  ///
  /// ---
  /// How works:
  ///
  /// This function deletes the element from the table, the where and whereArgs are used to identify the element to be deleted.
  ///
  /// ---
  /// Return:
  ///
  /// The return is the number of rows affected by the delete. If the return is 0, the deletion was not successful.
  Future<int> dbDelete({required TABLES table, required String where, required var whereArgs}) async {
    final db = await _get();

    final count = await db.delete(table.name, where: where, whereArgs: [whereArgs]);

    if (Global.printDeleteQuery && count == 0) log('0 rows affected by delete in table ${table.name}');

    return count;
  }
}