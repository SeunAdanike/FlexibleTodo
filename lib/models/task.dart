import 'dart:convert';

import 'package:flutter/material.dart';

class Task {
  final int id;
  final String title;
  final String category;
  final String progressType;
  final String todoDueDate;
  final String reminder;
  final String description;
  final Map<String, bool> measurables;
  final String todoFinishedDate;
  final bool isFinished;
  final String todoStartDate;

  const Task({
    @required this.title,
    @required this.category,
    @required this.id,
    @required this.progressType,
    @required this.description,
    @required this.todoStartDate,
    @required this.todoDueDate,
    this.todoFinishedDate,
    this.measurables,
    @required this.isFinished,
    @required this.reminder,
  });
  taskMap() {
    String measurableString = json.encode(measurables);
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['taskTitle'] = title;
    map['taskDescription'] = description;
    map['taskCategory'] = category;
    map['taskStartDate'] = todoStartDate;
    map['taskDueDate'] = todoDueDate;
    map['taskFinishedDate'] = todoFinishedDate;
    map['isTaskFinished'] = isFinished.toString();
    map['taskMeasurables'] = measurableString;
    map['taskProgressType'] = progressType;
    map['taskRemainder'] = reminder;
    return map;
  }
}
