import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final List<String> _categories = [
    'Academics',
    'Lifestyle',
    'Family',
    'Work',
    'Spiritual',
    'Business',
  ];
  bool isGradual = true;
  double sizeMenu = 30, sizeAddTask = 30, sizeProfile = 30, sizeSetting = 30;
  double sizeHome = 36;
  bool isMenu = false, isAddTask = false, isProfile = false, isSettings = false;
  bool isHome = true;
  var _categoriesController;

  DateTime _date = DateTime.now();
  var _dueDate = TextEditingController();

  var _clockController = TextEditingController();

  var _descriptionController = TextEditingController();

  var _measurableController = TextEditingController();
  var _measurable = List<String>();

  _selectDueDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2099),
        helpText: 'Select the Task due date',
        cancelText: 'Cancel',
        confirmText: 'Set',
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF8CE7F1),
              accentColor: const Color(0xFF8CE7F1),
              colorScheme:
                  ColorScheme.light(primary: Theme.of(context).primaryColor),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        });
    if (_pickedDate != null) {
      setState(() {
        _date = _pickedDate;
        _dueDate.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: Color(0xFFD2CECE),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
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
          right: 0,
          bottom: 30,
        ),
        child: SingleChildScrollView(
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Add a',
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        'New Task',
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.69,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: SvgPicture.asset(
                      'assets/images/Add task.svg',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 18.0,
                  top: 18.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 18.0,
                        left: 18.0,
                        bottom: 18,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Enter Task Name',
                              labelStyle: GoogleFonts.ubuntu(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              hintText: 'Place enter the name of the task',
                            ),
                            // validator: (value) {
                            //   if (value.isEmpty) {
                            //     return 'Please enter some text';
                            //   }
                            //   return null;
                            // },
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: DropdownButtonFormField(
                              value: _categoriesController,
                              items: _categories
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
                                  _categoriesController = value;
                                });
                              },
                              hint: Text(
                                'Select Task Category',
                                style: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Progress Type',
                                        style: GoogleFonts.ubuntu(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontSize: 17),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.info_outline,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    isGradual
                                        ? Row(
                                            children: [
                                              RaisedButton(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                shape: StadiumBorder(),
                                                onPressed: () {},
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, right: 8),
                                                  child: Text(
                                                    'Gradual',
                                                    style: GoogleFonts.ubuntu(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.check,
                                                size: 30,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )
                                            ],
                                          )
                                        : OutlineButton(
                                            onPressed: () {
                                              setState(() {
                                                isGradual = true;
                                              });
                                            },
                                            child: Text(
                                              "Gradual",
                                              style: GoogleFonts.ubuntu(
                                                  fontSize: 16,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            shape: StadiumBorder(),
                                          ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    isGradual
                                        ? OutlineButton(
                                            onPressed: () {
                                              setState(() {
                                                isGradual = false;
                                                _measurable = [];
                                              });
                                            },
                                            child: Text(
                                              "Definite",
                                              style: GoogleFonts.ubuntu(
                                                  fontSize: 16,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            shape: StadiumBorder(),
                                          )
                                        : Row(
                                            children: [
                                              RaisedButton(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                shape: StadiumBorder(),
                                                onPressed: () {},
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, right: 8),
                                                  child: Text(
                                                    'Definite',
                                                    style: GoogleFonts.ubuntu(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.check,
                                                size: 30,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )
                                            ],
                                          )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  controller: _dueDate,
                                  decoration: InputDecoration(
                                    hintText: 'YY-MM-DD',
                                    labelText: 'Due Date',
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          _selectDueDate(context);
                                        },
                                        child: Icon(Icons.calendar_today)),
                                    labelStyle: GoogleFonts.ubuntu(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // validator: (value) {
                                  //   if (value.isEmpty) {
                                  //     return 'Please enter some text';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  controller: _clockController,
                                  decoration: InputDecoration(
                                    hintText: '00:00',
                                    labelText: 'Set Alarm',
                                    suffixIcon: InkWell(
                                        onTap: () {},
                                        child: Icon(Icons.alarm_add_outlined)),
                                    labelStyle: GoogleFonts.ubuntu(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // validator: (value) {
                                  //   if (value.isEmpty) {
                                  //     return 'Please enter some text';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              )
                            ],
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              hintText:
                                  'Please Enter the detailed task description',
                              labelText: 'Task Description',
                              labelStyle: GoogleFonts.ubuntu(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            // validator: (value) {
                            //   if (value.isEmpty) {
                            //     return 'Please enter some text';
                            //   }
                            //   return null;
                            // },
                          ),
                          if (_measurable.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        _measurable[index],
                                        style: GoogleFonts.ubuntu(fontSize: 18),
                                        softWrap: true,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _measurable.removeAt(index);
                                        });
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                );
                              },
                              itemCount: _measurable.length,
                            ),
                          if (isGradual)
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,

                              controller: _measurableController,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (_measurableController
                                          .text.isNotEmpty) {
                                        _measurable
                                            .add(_measurableController.text);
                                        _measurableController.clear();
                                      }
                                    });
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                hintText: 'Please Enter Measurables',
                                labelText: 'Measurables',
                                labelStyle: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              // validator: (value) {
                              //   if (value.isEmpty) {
                              //     return 'Please enter some text';
                              //   }
                              //   return null;
                              // },
                            ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 28.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RaisedButton(
                                  color: Theme.of(context).primaryColor,
                                  shape: StadiumBorder(),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Text(
                                      'Save',
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                OutlineButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Clear",
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
