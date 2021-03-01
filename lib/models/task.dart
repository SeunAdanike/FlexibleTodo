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
