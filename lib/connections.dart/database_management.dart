import 'package:flexibletodo/connections.dart/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseConnections _databaseConnections;
  String table = 'TaskList';
  DatabaseManager() {
    _databaseConnections = DatabaseConnections();
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnections.setDatabase();
    return _database;
  }

  saveTask(toAddData) async {
    Database connector = await database;
    return await connector.insert(
      table,
      toAddData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  getAllTask() async {
    Database connector = await database;
    return connector.query(table);
  }

  getTaskById(taskId) async {
    Database connector = await database;
    return await connector.query(table, where: 'id =?', whereArgs: [taskId]);
  }

  update(taskData) async {
    Database connector = await database;
    return await connector
        .update(table, taskData, where: 'id = ?', whereArgs: [taskData['id']]);
  }

  delete(itemId) async {
    Database connector = await database;
    return await connector.rawDelete('DELETE FROM $table WHERE id = $itemId');
  }

  getByValue(String valueFieldName, String columnValue) async {
    Database connector = await database;
    return await connector
        .query(table, where: '$valueFieldName = ?', whereArgs: [columnValue]);
  }
}
