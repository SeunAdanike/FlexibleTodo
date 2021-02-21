import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnections {
  setDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'FlexTodo.db');
    final Future<Database> database =
        openDatabase(path, version: 1, onCreate: _onOpeningDatabase);
    return database;
  }

  _onOpeningDatabase(Database db, int version) async {
    return await db.execute(
        "CREATE TABLE TaskList(id INTEGER PRIMARY KEY, taskTitle TEXT, taskCategory TEXT, taskStartDate TEXT,  taskFinishedDate TEXT, taskProgressType TEXT, taskDueDate TEXT, taskRemainder TEXT, taskDescription TEXT, taskMeasurables TEXT, isTaskFinished TEXT)");
  }
}
