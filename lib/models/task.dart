import 'package:flutter/cupertino.dart';

class Task {
  final int id;
  final String title;
  final String category;
  final String progressType;
  final String description;
  final String todoStartDate;
  final String todoDueDate;
  final List<String> measurables;
  final bool isFinished;
  const Task({
    @required this.title,
    @required this.category,
    @required this.id,
    @required this.progressType,
    @required this.description,
    @required this.todoStartDate,
    @required this.todoDueDate,
    this.measurables,
    @required this.isFinished,
  });
  taskMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['category'] = category;
    map['todoStartDate'] = todoStartDate;
    map['todoDueDate'] = todoDueDate;
    map['isFinished'] = isFinished;
    map['measurables'] = measurables;
    map['progressType'] = progressType;
    return map;
  }
}
