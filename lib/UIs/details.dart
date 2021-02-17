import 'package:flexibletodo/UIs/allTask.dart';
import 'package:flexibletodo/models/task.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoDetailsScreen extends StatefulWidget {
  final Task task;

  TodoDetailsScreen({@required this.task});
  @override
  _TodoDetailsScreenState createState() => _TodoDetailsScreenState(task);
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  double sizeMenu = 30, sizeAddTask = 30, sizeProfile = 30, sizeSetting = 30;
  double sizeHome = 36;
  bool isMenu = false, isAddTask = false, isProfile = false, isSettings = false;
  bool isHome = true;

  Task _task;

  var _scrollController = ScrollController();
  _TodoDetailsScreenState(this._task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: Color(0xFFD2CECE),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 1, bottom: 3),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: sizeMenu,
                    color: isMenu
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorLight,
                  ),
                  onPressed: () {
                    setState(() {
                      isMenu = true;
                      isHome = isAddTask = isProfile = isSettings = false;
                      sizeMenu = 36;
                      sizeHome = sizeAddTask = sizeProfile = sizeSetting = 30;
                    });
                  },
                ),
                Text(
                  'Menu',
                  style: GoogleFonts.ubuntu(
                    fontWeight: isMenu ? FontWeight.bold : FontWeight.normal,
                    fontSize: sizeMenu / 2,
                    color: isMenu
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorLight,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    size: sizeHome,
                    color: isHome
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorLight,
                  ),
                  onPressed: () {
                    setState(() {
                      isHome = true;
                      isMenu = isAddTask = isProfile = isSettings = false;
                      sizeHome = 36;
                      sizeMenu = sizeAddTask = sizeProfile = sizeSetting = 30;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AllTask(),
                        ),
                      );
                    });
                  },
                ),
                Text(
                  'Home',
                  style: GoogleFonts.ubuntu(
                    fontSize: sizeHome / 2,
                    fontWeight: isHome ? FontWeight.bold : FontWeight.normal,
                    color: isHome
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorLight,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.add_box,
                    size: sizeAddTask,
                    color: isAddTask
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorLight,
                  ),
                  onPressed: () {
                    setState(() {
                      isAddTask = true;
                      isMenu = isHome = isProfile = isSettings = false;
                      sizeAddTask = 36;
                      sizeMenu = sizeHome = sizeProfile = sizeSetting = 30;
                    });
                  },
                ),
                Text(
                  'Add Task',
                  style: GoogleFonts.ubuntu(
                    fontWeight: isAddTask ? FontWeight.bold : FontWeight.normal,
                    color: isAddTask
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorLight,
                    fontSize: sizeAddTask / 2,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.person,
                    size: sizeProfile,
                    color: isProfile
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorLight,
                  ),
                  onPressed: () {
                    setState(() {
                      isProfile = true;
                      isMenu = isHome = isAddTask = isSettings = false;
                      sizeProfile = 36;
                      sizeMenu = sizeAddTask = sizeHome = sizeSetting = 30;
                    });
                  },
                ),
                Text(
                  'Profile',
                  style: GoogleFonts.ubuntu(
                    fontWeight: isProfile ? FontWeight.bold : FontWeight.normal,
                    color: isProfile
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorLight,
                    fontSize: sizeProfile / 2,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    size: sizeSetting,
                    color: isSettings
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorLight,
                  ),
                  onPressed: () {
                    setState(() {
                      isSettings = true;
                      isMenu = isHome = isAddTask = isProfile = false;
                      sizeSetting = 36;
                      sizeMenu = sizeAddTask = sizeHome = sizeProfile = 30;
                    });
                  },
                ),
                Text(
                  'Setting',
                  style: GoogleFonts.ubuntu(
                    fontWeight:
                        isSettings ? FontWeight.bold : FontWeight.normal,
                    color: isSettings
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorLight,
                    fontSize: sizeSetting / 2,
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
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
            Divider(
              height: 8,
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.68,
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
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 6,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.41,
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
                                    top: 15,
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
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                                softWrap: true,
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child:
                                                    Icon(Icons.edit_outlined),
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
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _task.category,
                                                    style: GoogleFonts.ubuntu(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                    softWrap: true,
                                                  ),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Icon(
                                                        Icons.edit_outlined),
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
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                                softWrap: true,
                                              ),
                                            ],
                                          )
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
                                            '${_task.todoDueDate} at ${_task.time}',
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
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      if (_task.measurables != null)
                                        if (_task.measurables.isNotEmpty)
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Measurables',
                                                    style: GoogleFonts.ubuntu(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
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
                                                itemBuilder: (context, index) {
                                                  List<String>
                                                      measurablesDetails = _task
                                                          .measurables.keys
                                                          .toList();
                                                  Map<String, bool>
                                                      _newMeasurables =
                                                      Map.fromIterable(
                                                          measurablesDetails,
                                                          key: (k) =>
                                                              measurablesDetails[
                                                                  index],
                                                          value: (v) => _task
                                                                  .measurables[
                                                              '${measurablesDetails[index]}']);
                                                  return ListTile(
                                                    onTap: () {
                                                      setState(() {});
                                                      print(_newMeasurables[
                                                          '${measurablesDetails[index]}']);
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
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        measurablesDetails[
                                                            index],
                                                        softWrap: true,
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ),
                                                    leading: _newMeasurables[
                                                            '${measurablesDetails[index]}']
                                                        ? Icon(
                                                            Icons
                                                                .check_box_outlined,
                                                            color: Colors.black,
                                                          )
                                                        : Icon(Icons
                                                            .check_box_outline_blank_sharp),
                                                  );
                                                },
                                                itemCount:
                                                    _task.measurables.length,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RaisedButton(
                                  shape: StadiumBorder(),
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {},
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
                                  onPressed: () {},
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
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete_outline_outlined,
                                  color: Colors.red,
                                ),
                                label: Text(
                                  'Delete',
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
    );
  }
}
