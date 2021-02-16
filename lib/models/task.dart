import 'package:flutter/cupertino.dart';

class Task {
  int id;
  String title;
  String category;
  String description;
  String todoStartDate;
  String todoDueDate;
  List<String> measurables;
  bool isFinished;
  Task({
    @required this.title,
    @required this.category,
    @required this.id,
    @required this.description,
    @required this.todoStartDate,
    @required this.todoDueDate,
    this.measurables,
    @required this.isFinished,
  });
  // taskMap() {
  //   var map = Map<String, dynamic>();
  //   map['id'] = id;
  //   map['title'] = title;
  //   map['description'] = description;
  //   map['category'] = category;
  //   map['todoStartDate'] = todoStartDate;
  //   map['todoDueDate'] = todoDueDate;
  //   map['isFinished'] = isFinished;
  //   map['measurables'] = measurables;
  //   return map;
  // }
}

//final Task first = Task(id: 1,category: 'Academics' );
