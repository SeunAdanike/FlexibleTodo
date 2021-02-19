import 'package:flutter/cupertino.dart';

class Task {
  final int id;
  final String title;
  final String category;
  final String progressType;
  final String description;
  final String todoStartDate;
  final String todoDueDate;
  final String todoFinishedDate;

  final Map<String, bool> measurables;
  final bool isFinished;
  final String time;
  const Task({
    @required this.title,
    @required this.category,
    @required this.id,
    @required this.progressType,
    @required this.description,
    @required this.todoStartDate,
    @required this.todoDueDate,
    @required this.todoFinishedDate,
    this.measurables,
    @required this.isFinished,
    @required this.time,
  });
  taskMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['category'] = category;
    map['todoStartDate'] = todoStartDate;
    map['todoDueDate'] = todoDueDate;
    map['todoFinishedDate'] = todoDueDate;
 
    map['isFinished'] = isFinished;
    map['measurables'] = measurables;
    map['progressType'] = progressType;
    map['finishedTime'] = time;
    return map;
  }
}
