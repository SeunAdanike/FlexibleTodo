import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flexibletodo/UIs/details.dart';
import 'package:flexibletodo/connections.dart/database_management.dart';

import 'package:flexibletodo/models/task.dart';
import 'package:flexibletodo/widgets/drawer.dart';
import 'package:flexibletodo/widgets/edgeDesign.dart';
import 'package:flexibletodo/widgets/menubar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllTask extends StatefulWidget {
  @override
  _AllTaskState createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  List _taskList = List<Task>();
  DatabaseManager _databaseManager = DatabaseManager();
  void _getAllValues() async {
    _taskList = List<Task>();
    var tasks = await _databaseManager.getAllTask();
    tasks.forEach((task) {
      setState(() {
        bool _isFinished;
        task['taskFinished'].toLowerCase() == 'true'
            ? _isFinished = true
            : _isFinished = false;

        Task taskModel = Task();
        taskModel.id = task['id'];
        taskModel.title = task['taskTitle'];
        taskModel.category = task['taskCategory'];
        taskModel.todoStartDate = task['taskStartDate'];
        taskModel.todoFinishedDate = task['taskFinishedDate'];
        taskModel.progressType = task['taskProgressType'];
        taskModel.todoDueDate = task['taskDueDate'];
        taskModel.reminder = task['taskRemainder'];
        taskModel.description = task['taskDescription'];
        taskModel.isFinished = _isFinished;
        _taskList.add(taskModel);
      });
    });
  }

  @override
  void initState() {
    _getAllValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      extendBody: true,
      bottomNavigationBar: MenuBar(
        isHome: true,
        sizeHome: 36,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          EdgeDesign(),
          Padding(
            padding: const EdgeInsets.only(
              top: 38.0,
              left: 15,
              right: 15,
              bottom: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        'assets/images/Foyeke.jpg',
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Hello, ',
                              style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                            Text(
                              'Tito',
                              style: GoogleFonts.ubuntu(
                                color: Colors.yellowAccent,
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Good morning!',
                          style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '6th February, 2020',
                          style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Text(
                      'All Tasks',
                      style: GoogleFonts.ubuntu(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '(${_taskList.length})',
                      style: GoogleFonts.ubuntu(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 18.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TodoDetailsScreen(
                                      task: _taskList[index],
                                    )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                bottom: 8,
                                right: 20,
                                left: 20,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .45,
                                            child: AutoSizeText(
                                              _taskList[index].title,
                                              softWrap: true,
                                              style: GoogleFonts.ubuntu(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            _taskList[index].category,
                                            style: GoogleFonts.ubuntu(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _taskList[index].isFinished
                                                ? 'Done'
                                                : 'Pending',
                                            style: GoogleFonts.ubuntu(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Divider(
                                            height: 6,
                                          ),
                                          Text(
                                            _taskList[index].isFinished
                                                ? 'Completed'
                                                : 'Due on ${_taskList[index].todoDueDate}',
                                            style: GoogleFonts.ubuntu(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(children: [
                                        Text(
                                          'Delete',
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                        ),
                                      ]),
                                      Row(children: [
                                        Text(
                                          'Edit',
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Icon(
                                          Icons.edit,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ]),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: _taskList.length,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
