import 'package:flexibletodo/connections.dart/database_connection.dart';
import 'package:flexibletodo/models/measurables.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseConnections _databaseConnections;
  String table = 'TaskList';
  String measurableTable = 'Measurables';
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

  saveMeasurables(measurablesAdding) async {
    Database connector = await database;
    return await connector.insert(measurableTable, measurablesAdding);
  }

  getAllTask() async {
    Database connector = await database;
    return await connector.query(table);
  }

  getAllMeasurables() async {
    Database connector = await database;
    return await connector.query(measurableTable);
  }

  getTaskById(taskId) async {
    Database connector = await database;
    var result =
        await connector.query(table, where: 'id =?', whereArgs: [taskId]);
    return result.toList();
  }

  getMeasurablesById(measurableId) async {
    Database connector = await database;
    var result = await connector
        .query(measurableTable, where: 'id =?', whereArgs: [measurableId]);
    return result.toList();
  }

  getByValue(String valueFieldName, String columnValue) async {
    Database connector = await database;
    return await connector
        .query(table, where: '$valueFieldName = ?', whereArgs: [columnValue]);
  }

  update(taskData) async {
    Database connector = await database;
    return await connector
        .update(table, taskData, where: 'id = ?', whereArgs: [taskData['id']]);
  }

  updateMeasurable(measurableData) async {
    Database connector = await database;
    return await connector.update(measurableTable, measurableData,
        where: 'id = ?', whereArgs: [measurableData['id']]);
  }

  delete(itemId) async {
    Database connector = await database;
    return await connector.rawDelete('DELETE FROM $table WHERE id = $itemId');
  }

  deleteMeasures(itemId) async {
    Database connector = await database;
    return await connector
        .rawDelete('DELETE FROM $measurableTable WHERE id = $itemId');
  }
}
