import 'package:flexibletodo/UIs/details.dart';
import 'package:flexibletodo/connections.dart/database_management.dart';
import 'package:flexibletodo/main.dart';
import 'package:flexibletodo/models/task.dart';
import 'package:flexibletodo/widgets/drawer.dart';
import 'package:flexibletodo/widgets/edgeDesign.dart';
import 'package:flexibletodo/widgets/menubar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FilterHelper extends StatefulWidget {
  final String field;
  FilterHelper({@required this.field});
  @override
  _FilterHelperState createState() => _FilterHelperState();
}

class _FilterHelperState extends State<FilterHelper> {
  List<Task> _fetchedTask = List<Task>();

  List _taskList = List<Task>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  DatabaseManager _databaseManager = DatabaseManager();

  DateTime pageGreet;

  int minute;

  int hour;
  _showSnackBar(message) {
    var _snackBar = SnackBar(
      content: message,
    );
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(_snackBar);
  }

  _comfirmationDialog(BuildContext context, Task task) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (value) {
        return AlertDialog(
            actionsPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Center(child: Text('Delete Confirmation')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Are you sure you want to delete the task?',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                      fontSize: 20,
                      color: Colors.black,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () async {
                        DateTime saveScheduleTime =
                            DateTime.fromMillisecondsSinceEpoch(task.id);
                        int scheduleId = (saveScheduleTime.weekday +
                            saveScheduleTime.month +
                            saveScheduleTime.millisecond +
                            saveScheduleTime.year);
                        var result = await _databaseManager.delete(task.id);
                        await flutterLocalNotificationsPlugin
                            .cancel(scheduleId);
                        if (task.progressType == 'Gradual') {
                          await _databaseManager.deleteMeasures(task.id);
                        }
                        if (result > 0) {
                          _showSnackBar(Text('Task is successfully deleted'));
                        }
                        Navigator.pop(context);

                        setState(() {
                          _getAllValues().then((_) {
                            _placeGetter();
                          });
                        });
                      },
                      child: Text('Delete',
                          style: GoogleFonts.ubuntu(
                            fontSize: 18,
                            color: Colors.red,
                          )),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel',
                          style: GoogleFonts.ubuntu(
                            fontSize: 18,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
              ],
            ));
      },
    );
  }

  _getAllValues() async {
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

  _placeGetter() {
    _fetchedTask = List<Task>();
    for (int i = 0; i < _taskList.length; i++) {
      if (widget.field == 'Pending') {
        if (!_taskList[i].isFinished) _fetchedTask.add(_taskList[i]);
      }
      if (widget.field == 'Completed') {
        if (_taskList[i].isFinished) _fetchedTask.add(_taskList[i]);
      }
      if (_taskList[i].category == widget.field)
        _fetchedTask.add(
          _taskList[i],
        );
    }
  }

  @override
  void initState() {
    pageGreet = DateTime.now();
    hour = pageGreet.hour;
    minute = pageGreet.minute;
    _getAllValues().then((_) {
      _placeGetter();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                    SizedBox(
                      width: 7,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ((hour >= 0 && hour <= 11) && minute <= 59)
                              ? 'Hello there!'
                              : ((hour > 11 && hour <= 16) && minute <= 59)
                                  ? 'Hey there!'
                                  : 'Hi there!',
                          style: GoogleFonts.ubuntu(
                            fontStyle: FontStyle.italic,
                            color: Colors.yellowAccent,
                            fontSize: 23,
                          ),
                        ),
                        Text(
                          ((hour >= 0 && hour <= 11) && minute <= 59)
                              ? 'Good Morning!'
                              : ((hour > 11 && hour <= 16) && minute <= 59)
                                  ? 'Good Afternoon!'
                                  : 'Good Evening!',
                          style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          '${DateFormat.yMMMMEEEEd().format(pageGreet)}',
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
                      '${widget.field} Tasks',
                      style: GoogleFonts.ubuntu(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '(${_fetchedTask.length})',
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
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                        Text(
                                          _fetchedTask[index].title,
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          _fetchedTask[index].category,
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
                                          _fetchedTask[index].isFinished
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
                                          _fetchedTask[index].isFinished
                                              ? 'Completed'
                                              : 'Due on ${_fetchedTask[index].todoDueDate}',
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
                                    InkWell(
                                      onTap: () {
                                        _comfirmationDialog(
                                            context, _fetchedTask[index]);
                                      },
                                      child: Row(children: [
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
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TodoDetailsScreen(
                                                      task: _fetchedTask[index],
                                                    )));
                                      },
                                      child: Row(children: [
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
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: _fetchedTask.length,
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
