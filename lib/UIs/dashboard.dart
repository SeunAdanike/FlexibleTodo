import 'package:auto_size_text/auto_size_text.dart';
import 'package:flexibletodo/UIs/details.dart';
import 'package:flexibletodo/models/colors.dart';
import 'package:flexibletodo/models/dummyTask.dart';
import 'package:flexibletodo/models/task.dart';
import 'package:flexibletodo/widgets/drawer.dart';
import 'package:flexibletodo/widgets/edgeDesign.dart';
import 'package:flexibletodo/widgets/menubar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Dash extends StatefulWidget {
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  List<Task> _taskTitle = List<Task>();
  List<Task> _pendingTask = List<Task>();
  List<bool> _progressCal = List();
  int _unDone;
  int _percentage = 0;
  List<Task> _dueToday = List<Task>();

  var _scrollController = ScrollController();

  int _progressCalculator(Map<String, bool> measurables) {
    _unDone = 0;
    _progressCal = measurables.values.toList();
    for (int i = 0; i < _progressCal.length; i++) {
      if (!_progressCal[i]) _unDone++;
    }
    _percentage = ((_unDone / (_progressCal.length)) * 100).round();
    return _percentage;
  }

  @override
  void initState() {
    _taskTitle = DUMMY_TASK.toList();
    for (int i = 0; i < _taskTitle.length; i++) {
      if (_taskTitle[i].isFinished == false) _pendingTask.add(_taskTitle[i]);
      if (_taskTitle[i].todoDueDate == '21/04/05') _dueToday.add(_taskTitle[i]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: AppDrawer(),
      bottomNavigationBar: MenuBar(),
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
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Scrollbar(
                    thickness: 4,
                    radius: Radius.circular(15),
                    controller: _scrollController,
                    isAlwaysShown: true,
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
                              child: ListView.builder(
                                //shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      right: 18.0,
                                      left: 18.0,
                                    ),
                                    child: RotatedBox(
                                      quarterTurns: 3,
                                      child: LinearPercentIndicator(
                                        curve: Curves.easeIn,
                                        width: 150.0,
                                        animation: true,
                                        animationDuration: 2000,
                                        lineHeight: 10.0,
                                        percent: 0.5,
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                      ),
                                    ),
                                  );
                                },
                                itemCount: 18,
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
                              child: ListView.builder(
                                itemBuilder: (context, index) {
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              AutoSizeText(
                                                _pendingTask[index].title,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.ubuntu(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
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
                                                        Icons.category_outlined,
                                                        size: 15,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        'Category: ',
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  AutoSizeText(
                                                    _pendingTask[index]
                                                        .category,
                                                    style: GoogleFonts.ubuntu(
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
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      AutoSizeText(
                                                        'Start Date:  ',
                                                        maxLines: 1,
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  AutoSizeText(
                                                    _pendingTask[index]
                                                        .todoStartDate,
                                                    maxLines: 1,
                                                    style: GoogleFonts.ubuntu(
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
                                                        Icons.calendar_today,
                                                        size: 14,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      AutoSizeText(
                                                        'Due Date:  ',
                                                        maxLines: 1,
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  AutoSizeText(
                                                    _pendingTask[index]
                                                        .todoDueDate,
                                                    maxLines: 1,
                                                    style: GoogleFonts.ubuntu(
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
                                              if (_pendingTask[index]
                                                      .measurables ==
                                                  null)
                                                Text(
                                                  _pendingTask[index].isFinished
                                                      ? 'Done'
                                                      : 'Not yet done',
                                                  style: GoogleFonts.ubuntu(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: _pendingTask[index]
                                                            .isFinished
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : Colors.red,
                                                  ),
                                                ),
                                              if (_pendingTask[index]
                                                      .measurables !=
                                                  null)
                                                Column(
                                                  children: [
                                                    LinearPercentIndicator(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      curve: Curves.easeIn,
                                                      width: 150.0,
                                                      animation: true,
                                                      animationDuration: 2000,
                                                      lineHeight: 8.0,
                                                      percent: (_progressCalculator(
                                                              _pendingTask[
                                                                      index]
                                                                  .measurables) /
                                                          100),
                                                      linearStrokeCap:
                                                          LinearStrokeCap
                                                              .roundAll,
                                                      progressColor: (_percentage <=
                                                              30)
                                                          ? barColors['red']
                                                          : (_percentage <= 50)
                                                              ? barColors[
                                                                  'yellow']
                                                              : (_percentage <=
                                                                      80)
                                                                  ? barColors[
                                                                      'yellowish']
                                                                  : (_percentage <=
                                                                          99)
                                                                      ? barColors[
                                                                          'greenish']
                                                                      : barColors[
                                                                          'green'],
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
                                                    style: GoogleFonts.ubuntu(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    _pendingTask[index]
                                                        .progressType,
                                                    style: GoogleFonts.ubuntu(
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
                                  'Task due today',
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        setState(() {});
                                      },
                                      dense: false,
                                      contentPadding: EdgeInsets.zero,
                                      visualDensity: VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      title: Padding(
                                        padding: const EdgeInsets.all(8.0),
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
