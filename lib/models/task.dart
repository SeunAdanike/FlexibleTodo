import 'dart:convert';

import 'package:flutter/material.dart';

class Task {
  int id;
  String title;
  String category;
  String progressType;
  String todoDueDate;
  String reminder;
  String description;
  String todoFinishedDate;
  bool isFinished;
  String todoStartDate;

  Task({
    @required this.title,
    @required this.category,
    @required this.id,
    @required this.progressType,
    @required this.description,
    @required this.todoStartDate,
    @required this.todoDueDate,
    this.todoFinishedDate,
    @required this.isFinished,
    @required this.reminder,
  });
  taskMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['taskTitle'] = title;
    map['taskDescription'] = description;
    map['taskCategory'] = category;
    map['taskStartDate'] = todoStartDate;
    map['taskDueDate'] = todoDueDate;
    map['taskFinishedDate'] = todoFinishedDate;
    map['taskFinished'] = isFinished.toString();

    map['taskProgressType'] = progressType;
    map['taskRemainder'] = reminder;
    return map;
  }
}
