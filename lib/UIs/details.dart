import 'dart:convert';

import 'package:flexibletodo/connections.dart/database_management.dart';
import 'package:flexibletodo/models/categories.dart';
import 'package:flexibletodo/models/colors.dart';
import 'package:flexibletodo/models/measurables.dart';
import 'package:flexibletodo/models/task.dart';
import 'package:flexibletodo/widgets/drawer.dart';
import 'package:flexibletodo/main.dart';
import 'package:flexibletodo/widgets/edgeDesign.dart';
import 'package:flexibletodo/widgets/menubar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TodoDetailsScreen extends StatefulWidget {
  static const String routeName = '/Details';

  final Task task;

  TodoDetailsScreen({@required this.task});
  @override
  _TodoDetailsScreenState createState() => _TodoDetailsScreenState(task);
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  List<dynamic> _progressCal = List();
  int done = 0, unDone = 0;
  double percent = 0;
  int percentage = 0;
  Task _task;
  bool _isDone = false;
  var _scrollController = ScrollController();
  DatabaseManager _databaseManager = DatabaseManager();
  Measurables measuresFetched;
  List<Measurables> measurablesList;

  var _titleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  List<Task> _taskList = List<Task>();
  DateTime pageGreet;

  int hour;

  int minute;
  _TodoDetailsScreenState(this._task);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _showSnackBar(message) {
    var _snackBar = SnackBar(
      content: message,
    );
    _scaffoldKey.currentState.showSnackBar(_snackBar);
  }

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
                          _getAllValues();
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

  _getMeasuresbyId() async {
    measurablesList = List<Measurables>();
    var measures = await _databaseManager.getMeasurablesById(_task.id);
    measures.forEach((measure) {
      setState(() {
        bool _isTick;
        measure['isTicked'].toLowerCase() == 'true'
            ? _isTick = true
            : _isTick = false;
        Map<String, dynamic> _measureMap = jsonDecode(measure['measurable']);
        measuresFetched = Measurables();
        measuresFetched.id = measure['id'];
        measuresFetched.isTicked = _isTick;
        measuresFetched.measurables = _measureMap;
        measurablesList.add(measuresFetched);
      });
    });
  }

  String _categoriesHolder;

  _updateDialog(BuildContext context, String _field) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (value) {
        return AlertDialog(
            actionsPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text('Edit $_field',
                        style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        )),
                  ),
                  Divider(
                    height: 1,
                    color: Theme.of(context).primaryColor,
                    thickness: 1,
                  ),
                  Form(
                    key: _formKey,
                    child: _field == 'Title'
                        ? TextFormField(
                            maxLength: 20,
                            controller: _titleController,
                            decoration: InputDecoration(
                              labelText: 'Enter New $_field',
                              labelStyle: GoogleFonts.ubuntu(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              hintText: 'Please new $_field',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field should not be empty';
                              }
                              return null;
                            },
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: DropdownButtonFormField(
                              value: _categoriesHolder,
                              items: CATEGORIES
                                  .map(
                                    (label) => DropdownMenuItem(
                                      child: Text(
                                        label.toString(),
                                      ),
                                      value: label,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _categoriesHolder = value;
                                });
                              },
                              hint: Text(
                                'Select Task Category',
                                style: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              validator: (val) {
                                if (val == null) {
                                  return 'Please Select a Category Text';
                                }
                                return null;
                              },
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 18.0,
                      left: 18,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          shape: StadiumBorder(),
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              if (_field == 'Title') {
                                _task.title = _titleController.text;
                                await _databaseManager
                                    .update(_task.taskMap())
                                    .then((_) {
                                  _titleController.clear();
                                  Navigator.of(context).pop();
                                });
                              }
                              if (_field == 'Category') {
                                _task.category = _categoriesHolder;
                                await _databaseManager
                                    .update(_task.taskMap())
                                    .then((_) {
                                  _titleController.clear();
                                  Navigator.of(context).pop();
                                });
                              }
                            }
                            setState(() {});
                          },
                          child: Text(
                            'Update',
                            style: GoogleFonts.ubuntu(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        OutlineButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            _titleController.clear();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Close',
                            style: GoogleFonts.ubuntu(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                          ),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                          shape: StadiumBorder(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  int _percentCal() {
    done = 0;

    unDone = 0;

    if (measurablesList != null) if (measurablesList.isNotEmpty) {
      _progressCal = measurablesList[0].measurables.values.toList();
      for (int i = 0; i < _progressCal.length; i++) {
        if (_progressCal[i] == true)
          done++;
        else
          unDone++;
      }
      percent = done / (done + unDone);
      percentage = (percent * 100).round();
    }
    return percentage;
  }

  @override
  void initState() {
    pageGreet = DateTime.now();
    hour = pageGreet.hour;
    minute = pageGreet.minute;
    _isDone = _task.isFinished;
    _getMeasuresbyId().then((_) {
      _percentCal();
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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 32.0,
                    left: 15,
                    right: 0,
                  ),
                  child: Row(
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
                            ((hour >= 0 && hour <= 11) && minute <= 59)
                                ? 'Good Morning!'
                                : ((hour > 11 && hour <= 16) && minute <= 59)
                                    ? 'Good Afternoon!'
                                    : 'Good Evening!',
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 20,
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
                ),
                Divider(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.16,
                      child: SvgPicture.asset(
                        'assets/images/Details.svg',
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomLeft,
                      ),
                    ),
                    Text(
                      'Task \nDetails',
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      Divider(
                        height: 6,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: MediaQuery.of(context).size.height * 0.535,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.40,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5,
                                  right: 5,
                                  left: 5,
                                ),
                                child: Scrollbar(
                                  radius: Radius.circular(15),
                                  isAlwaysShown: true,
                                  controller: _scrollController,
                                  child: SingleChildScrollView(
                                    controller: _scrollController,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 18.0,
                                        left: 18.0,
                                        bottom: 18,
                                        top: 10,
                                      ),
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'Task Title',
                                                style: GoogleFonts.ubuntu(
                                                  fontSize: 16,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _task.title,
                                                    style: GoogleFonts.ubuntu(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                    softWrap: true,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      _updateDialog(
                                                          context, 'Title');
                                                    },
                                                    child: Icon(
                                                        Icons.edit_outlined),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    'Category',
                                                    style: GoogleFonts.ubuntu(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        _task.category,
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                        softWrap: true,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          _updateDialog(context,
                                                              'Category');
                                                        },
                                                        child: Icon(Icons
                                                            .edit_outlined),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'Progress Type',
                                                    style: GoogleFonts.ubuntu(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    _task.progressType,
                                                    style: GoogleFonts.ubuntu(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                    softWrap: true,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                'Progress',
                                                style: GoogleFonts.ubuntu(
                                                  fontSize: 16,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              if (_task.progressType ==
                                                  'Definite')
                                                Row(
                                                  children: [
                                                    Text(
                                                      _isDone
                                                          ? 'Done'
                                                          : 'Not yet done',
                                                      style: GoogleFonts.ubuntu(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: _isDone
                                                              ? Colors.black
                                                              : barColors[
                                                                  'red']),
                                                    ),
                                                    IconButton(
                                                      color: _isDone
                                                          ? Color(0xFF1329F2)
                                                          : Colors.black,
                                                      onPressed: () {
                                                        setState(() {
                                                          _isDone = !_isDone;
                                                          _task.isFinished =
                                                              _isDone;
                                                        });
                                                      },
                                                      icon: Icon(
                                                        _isDone
                                                            ? Icons.check_box
                                                            : Icons
                                                                .check_box_outline_blank_outlined,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (measurablesList != null)
                                                if (measurablesList.isNotEmpty)
                                                  Column(
                                                    children: [
                                                      LinearPercentIndicator(
                                                        curve: Curves.easeIn,
                                                        width: 150.0,
                                                        animation: true,
                                                        animationDuration: 2000,
                                                        lineHeight: 10.0,
                                                        percent: percent,
                                                        linearStrokeCap:
                                                            LinearStrokeCap
                                                                .roundAll,
                                                        progressColor: (percentage <=
                                                                30)
                                                            ? barColors['red']
                                                            : (percentage <= 50)
                                                                ? barColors[
                                                                    'yellow']
                                                                : (percentage <=
                                                                        80)
                                                                    ? barColors[
                                                                        'yellowish']
                                                                    : (percentage <=
                                                                            99)
                                                                        ? barColors[
                                                                            'greenish']
                                                                        : barColors[
                                                                            'green'],
                                                      ),
                                                      Text(
                                                        '${(percent * 100).ceil()}% Completed!',
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                            ],
                                          ),
                                          Divider(),
                                          Column(
                                            children: [
                                              Text(
                                                'This task is due to be completed on the',
                                                style: GoogleFonts.ubuntu(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              Text(
                                                '${_task.todoDueDate} at ${_task.reminder}',
                                                style: GoogleFonts.ubuntu(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                          Divider(),
                                          Column(
                                            children: [
                                              Text(
                                                'Task Description',
                                                style: GoogleFonts.ubuntu(
                                                  fontSize: 16,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              Text(
                                                '${_task.description}',
                                                style: GoogleFonts.ubuntu(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                ),
                                                softWrap: true,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                          if (measurablesList != null)
                                            if (measurablesList.isNotEmpty)
                                              Divider(),
                                          if (measurablesList != null)
                                            if (measurablesList.isNotEmpty)
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Measurables',
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                          fontSize: 16,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .add_circle_outline_rounded,
                                                        size: 20,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      )
                                                    ],
                                                  ),
                                                  ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      List<String>
                                                          measurablesDetails =
                                                          measurablesList[0]
                                                              .measurables
                                                              .keys
                                                              .toList();
                                                      bool val = measurablesList[
                                                                  0]
                                                              .measurables[
                                                          '${measurablesDetails[index]}'];

                                                      return ListTile(
                                                        onTap: () async {
                                                          setState(() {
                                                            measurablesList[0]
                                                                        .measurables[
                                                                    '${measurablesDetails[index]}'] =
                                                                !measurablesList[
                                                                            0]
                                                                        .measurables[
                                                                    '${measurablesDetails[index]}'];
                                                            if (measurablesList[
                                                                        0]
                                                                    .measurables[
                                                                '${measurablesDetails[index]}'])
                                                              _databaseManager
                                                                  .updateMeasurable(
                                                                      measurablesList[
                                                                              0]
                                                                          .toMap());
                                                            _percentCal();
                                                          });
                                                        },
                                                        dense: false,
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        visualDensity:
                                                            VisualDensity(
                                                                horizontal: 0,
                                                                vertical: -4),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            measurablesDetails[
                                                                index],
                                                            softWrap: true,
                                                            style: GoogleFonts
                                                                .ubuntu(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ),
                                                        leading: val
                                                            ? Icon(
                                                                Icons
                                                                    .check_box_outlined,
                                                                color: Colors
                                                                    .black,
                                                              )
                                                            : Icon(Icons
                                                                .check_box_outline_blank_sharp),
                                                      );
                                                    },
                                                    itemCount:
                                                        measurablesList[0]
                                                            .measurables
                                                            .length,
                                                  )
                                                ],
                                              )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    RaisedButton(
                                      shape: StadiumBorder(),
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () async {
                                        setState(() {
                                          _percentCal();
                                          if (_task.progressType == 'Gradual') {
                                            if (percent >= 1) {
                                              _task.isFinished = true;
                                              _task.todoFinishedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(
                                                DateTime.now(),
                                              );
                                            } else {
                                              _task.isFinished = false;
                                              _task.todoFinishedDate = null;
                                            }
                                          }
                                          if (_task.progressType ==
                                              'Definite') {
                                            if (_isDone) {
                                              _task.isFinished = true;
                                              _task.todoFinishedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(
                                                DateTime.now(),
                                              );
                                            } else {
                                              _task.isFinished = false;
                                              _task.todoFinishedDate = null;
                                            }
                                          }
                                        });
                                        if (_task.progressType == 'Gradual') {
                                          await _databaseManager
                                              .updateMeasurable(
                                                  measurablesList[0].toMap());
                                        }

                                        var result = await _databaseManager
                                            .update(_task.taskMap());
                                        if (result > 0) {
                                          _showSnackBar(
                                              Text('Update Successful'));
                                        }
                                        Navigator.of(context)
                                            .popAndPushNamed('/Dash');
                                      },
                                      child: Text(
                                        'Update',
                                        style: GoogleFonts.ubuntu(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    OutlineButton(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      shape: StadiumBorder(),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: GoogleFonts.ubuntu(
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                OutlineButton.icon(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    shape: StadiumBorder(),
                                    onPressed: () {
                                      _comfirmationDialog(context, _task)
                                          .then((_) {
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete_outline_outlined,
                                      color: Colors.red,
                                    ),
                                    label: Text(
                                      'Delete Task',
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.black,
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
