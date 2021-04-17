import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flexibletodo/UIs/details.dart';
import 'package:flexibletodo/connections.dart/database_management.dart';
import 'package:flexibletodo/models/colors.dart';
import 'package:flexibletodo/models/measurables.dart';

import 'package:flexibletodo/models/task.dart';
import 'package:flexibletodo/widgets/drawer.dart';
import 'package:flexibletodo/widgets/edgeDesign.dart';
import 'package:flexibletodo/widgets/menubar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Dash extends StatefulWidget {
  static const String routeName = '/Dash';
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  List<Task> _pendingTask = List<Task>();
  List _progressCal = List();
  int _done;
  int _percentage;
  List<Task> _dueToday = List<Task>();
  String _enrolDate;
  Measurables measuresFetched;

  DateTime _todaysDate = DateTime.now();

  var _scrollController = ScrollController();

  int _differenceInDate = 0;

  DateTime pageGreet;
  String _date;
  int hour;

  int minute;

  int _progressCalculator(Map measurables) {
    _percentage = 0;
    _done = 0;
    _progressCal = measurables.values.toList();
    for (int i = 0; i < _progressCal.length; i++) {
      if (_progressCal[i] == true) _done++;
    }
    _percentage = ((_done / (_progressCal.length)) * 100).round();

    return _percentage;
  }

  List<int> _searchId = List<int>();
  List<Task> _taskList = List<Task>();
  List<Measurables> _measurablesList = List<Measurables>();
  var _databaseManager = DatabaseManager();

  _getAllMeasurables() async {
    _measurablesList = List<Measurables>();
    var measures = await _databaseManager.getAllMeasurables();
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
        _measurablesList.add(measuresFetched);
      });
    });
  }

  _getAllTasks() async {
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
        _searchId.add(task['id']);
      });
    });
  }

  Future<String> _getInstalledDate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Application application = await DeviceApps.getApp(packageInfo.packageName);
    var getDate =
        DateTime.fromMillisecondsSinceEpoch(application.installTimeMillis);
    _date = DateFormat('yyyy-MM-dd').format(getDate);
  }

  @override
  void initState() {
    pageGreet = DateTime.now();
    hour = pageGreet.hour;
    minute = pageGreet.minute;
    String toDayDate = DateFormat('yyyy-MM-dd').format(pageGreet);
    _pendingTask = List<Task>();
    _dueToday = List<Task>();
    _getAllTasks().then((_) {
      for (int i = 0; i < _taskList.length; i++) {
        if (_taskList[i].isFinished == false) _pendingTask.add(_taskList[i]);
        if (_taskList[i].todoDueDate == toDayDate) _dueToday.add(_taskList[i]);
      }
      if (_searchId.isNotEmpty) {
        int startBarDate = _searchId.reduce(min);
        _enrolDate = DateFormat('yyyy-MM-dd')
            .format(DateTime.fromMillisecondsSinceEpoch(startBarDate));
        DateTime _enrolDateConvert = DateTime.parse(_enrolDate);
        _differenceInDate = _todaysDate.difference(_enrolDateConvert).inDays;
      }
    });
    _getInstalledDate();
    _getAllMeasurables();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: AppDrawer(),
      bottomNavigationBar: MenuBar(
        isHome: true,
        sizeHome: 32,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          EdgeDesign(),
          Padding(
            padding: const EdgeInsets.only(
              top: 38.0,
              left: 15,
              right: 8,
              bottom: 30,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                Divider(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Scrollbar(
                    thickness: 4,
                    radius: Radius.circular(15),
                    controller: _scrollController,
                    isAlwaysShown: false,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                      ),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Completion bar',
                              style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            Divider(
                              height: 3,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              height: MediaQuery.of(context).size.height * 0.23,
                              child: (_enrolDate == null && _taskList.isEmpty)
                                  ? Center(
                                      child: AutoSizeText(
                                          'You haven\'t added any task yet',
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black54,
                                          )))
                                  //   CircularProgressIndicator(
                                  //   valueColor: AlwaysStoppedAnimation<Color>(
                                  //       Theme.of(context).primaryColor),
                                  // ))
                                  : ListView.builder(
                                      //shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        if (_taskList == null)
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                        .size
                                                        .width) *
                                                0.1,
                                            child: Center(
                                              child: AutoSizeText(
                                                  'You haven\'t added any task yet',
                                                  style: GoogleFonts.ubuntu(
                                                    fontSize: 20,
                                                  )),
                                            ),
                                          );
                                        int _finished = 0, _due = 0;

                                        DateTime _barDate =
                                            DateTime.parse(_date)
                                                .add(Duration(days: index));

                                        String _showDateOnBar =
                                            DateFormat.MMMd().format(
                                                DateTime.parse(
                                                    _barDate.toString()));

                                        String _showDayOnBar = DateFormat.E()
                                            .format(DateTime.parse(
                                                _barDate.toString()));

                                        String _compBarDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(_barDate);

                                        for (int i = 0;
                                            i < _taskList.length;
                                            i++) {
                                          if (_compBarDate ==
                                              _taskList[i].todoDueDate) _due++;

                                          if (_compBarDate ==
                                              _taskList[i]
                                                  .todoDueDate) if (_taskList[i]
                                              .isFinished) _finished++;
                                        }
                                        int _total;
                                        _due != 0
                                            ? _total =
                                                ((_finished / _due) * 100)
                                                    .ceil()
                                            : _total = 0;

                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 12.0,
                                            left: 12.0,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              RotatedBox(
                                                quarterTurns: 3,
                                                child: LinearPercentIndicator(
                                                  curve: Curves.easeIn,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.18,
                                                  animation: true,
                                                  animationDuration: 2000,
                                                  lineHeight: 10.0,
                                                  percent: _total.isNaN
                                                      ? 0
                                                      : (_total / 100),
                                                  linearStrokeCap:
                                                      LinearStrokeCap.roundAll,
                                                  progressColor: !_total.isNaN
                                                      ? (_total <= 30)
                                                          ? barColors['red']
                                                          : (_total <= 50)
                                                              ? barColors[
                                                                  'yellow']
                                                              : (_total <= 80)
                                                                  ? barColors[
                                                                      'yellowish']
                                                                  : (_total <=
                                                                          99)
                                                                      ? barColors[
                                                                          'greenish']
                                                                      : barColors[
                                                                          'green']
                                                      : barColors['red'],
                                                ),
                                              ),
                                              Text(
                                                '$_showDayOnBar.',
                                                style: GoogleFonts.ubuntu(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                              Text(
                                                '$_showDateOnBar.',
                                                style: GoogleFonts.ubuntu(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: _differenceInDate + 1,
                                      scrollDirection: Axis.horizontal,
                                    ),
                            ),
                            Divider(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Pending Tasks',
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                                Text(
                                  '(tap for details)',
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 3,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.23,
                              child: _pendingTask.isEmpty
                                  ? Center(
                                      child: Text(
                                        'You do not have any pending task yet.',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.ubuntu(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 20,
                                          color: Colors.white60,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemBuilder: (context, index) {
                                        double forIndicator;
                                        for (int i = 0;
                                            i < _measurablesList.length;
                                            i++) {
                                          if (_measurablesList[i].id ==
                                              _pendingTask[index].id) {
                                            forIndicator = (_progressCalculator(
                                                    _measurablesList[i]
                                                        .measurables)) /
                                                100;
                                          }
                                        }

                                        return InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TodoDetailsScreen(
                                                  task: _pendingTask[index],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                              right: 8.0,
                                              bottom: 8.0,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    AutoSizeText(
                                                      _pendingTask[index].title,
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.ubuntu(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .category_outlined,
                                                              size: 15,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(
                                                              'Category: ',
                                                              style: GoogleFonts
                                                                  .ubuntu(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        AutoSizeText(
                                                          _pendingTask[index]
                                                              .category,
                                                          style: GoogleFonts
                                                              .ubuntu(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Divider(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .calendar_today_outlined,
                                                              size: 14,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            AutoSizeText(
                                                              'Start Date:  ',
                                                              maxLines: 1,
                                                              style: GoogleFonts
                                                                  .ubuntu(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        AutoSizeText(
                                                          _pendingTask[index]
                                                              .todoStartDate,
                                                          maxLines: 1,
                                                          style: GoogleFonts
                                                              .ubuntu(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Divider(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .calendar_today,
                                                              size: 14,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            AutoSizeText(
                                                              'Due Date:  ',
                                                              maxLines: 1,
                                                              style: GoogleFonts
                                                                  .ubuntu(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        AutoSizeText(
                                                          _pendingTask[index]
                                                              .todoDueDate,
                                                          maxLines: 1,
                                                          style: GoogleFonts
                                                              .ubuntu(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Divider(
                                                      height: 5,
                                                    ),
                                                    if (_pendingTask[index]
                                                            .progressType ==
                                                        'Definite')
                                                      Text(
                                                        _pendingTask[index]
                                                                .isFinished
                                                            ? 'Done'
                                                            : 'Not yet done',
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: _pendingTask[
                                                                      index]
                                                                  .isFinished
                                                              ? Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                              : Colors.red,
                                                        ),
                                                      ),
                                                    if (_pendingTask[index]
                                                            .progressType ==
                                                        'Gradual')
                                                      Column(
                                                        children: [
                                                          LinearPercentIndicator(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            curve:
                                                                Curves.easeIn,
                                                            width: 150.0,
                                                            animation: true,
                                                            animationDuration:
                                                                2000,
                                                            lineHeight: 8.0,
                                                            percent:
                                                                forIndicator !=
                                                                        null
                                                                    ? forIndicator
                                                                    : 0.0,
                                                            linearStrokeCap:
                                                                LinearStrokeCap
                                                                    .roundAll,
                                                            progressColor: (_percentage ==
                                                                    null)
                                                                ? barColors[
                                                                    'red']
                                                                : (_percentage <=
                                                                        30)
                                                                    ? barColors[
                                                                        'red']
                                                                    : (_percentage <=
                                                                            50)
                                                                        ? barColors[
                                                                            'yellow']
                                                                        : (_percentage <=
                                                                                80)
                                                                            ? barColors['yellowish']
                                                                            : (_percentage <= 99)
                                                                                ? barColors['greenish']
                                                                                : barColors['green'],
                                                          ),
                                                          Divider(
                                                            height: 7,
                                                          ),
                                                        ],
                                                      ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          'Progress Type: ',
                                                          style: GoogleFonts
                                                              .ubuntu(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          _pendingTask[index]
                                                              .progressType,
                                                          style: GoogleFonts
                                                              .ubuntu(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: _pendingTask.length,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                    ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tasks due today',
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                                _dueToday.isEmpty
                                    ? Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 18.0),
                                          child: Text(
                                            'There is no task due for today',
                                            style: GoogleFonts.ubuntu(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 20,
                                              color: Colors.white60,
                                            ),
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TodoDetailsScreen(
                                                    task: _dueToday[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            dense: false,
                                            contentPadding: EdgeInsets.zero,
                                            visualDensity: VisualDensity(
                                                horizontal: 0, vertical: -4),
                                            title: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                _dueToday[index].title,
                                                softWrap: true,
                                                style: GoogleFonts.ubuntu(
                                                    fontSize: 17,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            leading: _dueToday[index].isFinished
                                                ? Icon(
                                                    Icons.check_box_outlined,
                                                    color: Colors.white,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .check_box_outline_blank_sharp,
                                                    color: Colors.white,
                                                  ),
                                          );
                                        },
                                        itemCount: _dueToday.length,
                                        shrinkWrap: true,
                                      )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
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
