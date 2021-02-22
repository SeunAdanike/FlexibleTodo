import 'package:flexibletodo/connections.dart/database_management.dart';
import 'package:flexibletodo/models/categories.dart';
import 'package:flexibletodo/models/measurables.dart';
import 'package:flexibletodo/models/task.dart';
import 'package:flexibletodo/widgets/drawer.dart';
import 'package:flexibletodo/widgets/edgeDesign.dart';
import 'package:flexibletodo/widgets/menubar.dart';
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
  bool isGradual = true;
  String _categoriesHolder;

  DateTime _date = DateTime.now();
  var _dueDate = TextEditingController();

  var _clockController = TextEditingController();

  var _descriptionController = TextEditingController();

  var _measurableController = TextEditingController();
  var _measurable = List<String>();

  var _scrollBarController = ScrollController();
  Task newTask;
  Measurables newMeasurables = Measurables();
  var _selectedTime;
  var todaysDate;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  DatabaseManager _databaseManager;
  Map<String, bool> measurestomap = Map<String, bool>();
  var _titleController = TextEditingController();

  _showSnackBar(message) {
    var _snackBar = SnackBar(
      content: message,
    );
    _scaffoldKey.currentState.showSnackBar(_snackBar);
  }

  int genId;

  @override
  void initState() {
    _databaseManager = DatabaseManager();
    todaysDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _selectedTime = TimeOfDay(hour: 12, minute: 30);
    super.initState();
  }

  Map<String, bool> _measurablesToMap() {
    measurestomap = Map<String, bool>();
    for (int i = 0; i < _measurable.length; i++) {
      measurestomap.putIfAbsent(_measurable[i], () => false);
    }
    return measurestomap;
  }

  _addTasktoDb() {
    genId = DateTime.now().millisecondsSinceEpoch;
    newTask = Task(
      id: genId,
      title: _titleController.text,
      category: _categoriesHolder.toString(),
      progressType: isGradual ? 'Gradual' : 'Definite',
      todoDueDate: _dueDate.text,
      reminder: _clockController.text,
      description: _descriptionController.text,
      isFinished: false,
      todoStartDate: todaysDate.toString(),
      todoFinishedDate: null,
    );
    if (isGradual) {
      newMeasurables.id = genId;
      newMeasurables.measurables = _measurablesToMap();
      newMeasurables.isTicked = false;
    }
    print(newTask.id);
  }

  _clearFields() {
    setState(() {
      _titleController.clear();
      isGradual = true;

      _clockController.clear();
      _descriptionController.clear();
      _measurable = [];

      _dueDate.clear();
    });
  }

  _selectDueTime(BuildContext context) async {
    var _timePicked = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
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

    setState(() {
      _selectedTime = _timePicked;
      if (_timePicked != null)
        _clockController.text = '${_timePicked.format(context)}';
    });
  }

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
      key: _scaffoldKey,
      drawer: AppDrawer(),
      extendBody: true,
      bottomNavigationBar: MenuBar(
        sizeAddTask: 36,
        isAddTask: true,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          EdgeDesign(),
          Padding(
            padding: const EdgeInsets.only(
              top: 30.0,
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
                  Divider(
                    height: 3,
                  ),
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
                      top: 10.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 2.0,
                        ),
                        child: Scrollbar(
                          radius: Radius.circular(20),
                          isAlwaysShown: true,
                          controller: _scrollBarController,
                          child: SingleChildScrollView(
                            controller: _scrollBarController,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 18.0,
                                left: 18.0,
                                bottom: 18,
                              ),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: _titleController,
                                      decoration: InputDecoration(
                                        labelText: 'Enter Task Name',
                                        labelStyle: GoogleFonts.ubuntu(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                        hintText:
                                            'Place enter the name of the task',
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please Enter the Task Title';
                                        }
                                        return null;
                                      },
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
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
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Progress Type',
                                                  style: GoogleFonts.ubuntu(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                      fontSize: 17),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  Icons.info_outline,
                                                  color: Theme.of(context)
                                                      .primaryColor,
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
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          shape:
                                                              StadiumBorder(),
                                                          onPressed: () {},
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0,
                                                                    right: 8),
                                                            child: Text(
                                                              'Gradual',
                                                              style: GoogleFonts
                                                                  .ubuntu(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.check,
                                                          size: 30,
                                                          color:
                                                              Theme.of(context)
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
                                                            color: Theme.of(
                                                                    context)
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
                                                            color: Theme.of(
                                                                    context)
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
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          shape:
                                                              StadiumBorder(),
                                                          onPressed: () {},
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0,
                                                                    right: 8),
                                                            child: Text(
                                                              'Definite',
                                                              style: GoogleFonts
                                                                  .ubuntu(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.check,
                                                          size: 30,
                                                          color:
                                                              Theme.of(context)
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
                                                  child: Icon(
                                                      Icons.calendar_today)),
                                              labelStyle: GoogleFonts.ubuntu(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please Enter the Due Date';
                                              }
                                              return null;
                                            },
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
                                              labelText: 'Set Reminder',
                                              suffixIcon: InkWell(
                                                  onTap: () {
                                                    _selectDueTime(context);
                                                  },
                                                  child: Icon(Icons
                                                      .alarm_add_outlined)),
                                              labelStyle: GoogleFonts.ubuntu(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please Pick a Time';
                                              }
                                              return null;
                                            },
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
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please Enter the Task Description';
                                        }
                                        return null;
                                      },
                                    ),
                                    if (_measurable.isNotEmpty)
                                      ListView.builder(
                                        padding: EdgeInsets.only(
                                          top: 10,
                                        ),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '${index + 1}',
                                                  style: GoogleFonts.ubuntu(
                                                      fontSize: 18),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    _measurable[index],
                                                    style: GoogleFonts.ubuntu(
                                                        fontSize: 18),
                                                    softWrap: true,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _measurable
                                                          .removeAt(index);
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              ],
                                            ),
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
                                                  _measurable.add(
                                                      _measurableController
                                                          .text);
                                                  _measurableController.clear();
                                                  _formKey.currentState
                                                      .validate();
                                                }
                                              });
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          hintText: 'Please Enter Measurables',
                                          labelText: 'Measurables',
                                          labelStyle: GoogleFonts.ubuntu(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                        validator: (_) {
                                          if (_measurable.isEmpty) {
                                            return 'Please Enter Task Measurables';
                                          }
                                          return null;
                                        },
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 28.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          RaisedButton(
                                            color:
                                                Theme.of(context).primaryColor,
                                            shape: StadiumBorder(),
                                            onPressed: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _addTasktoDb();
                                                var addingTask =
                                                    await _databaseManager
                                                        .saveTask(
                                                            newTask.taskMap());

                                                if (isGradual)
                                                  await _databaseManager
                                                      .saveMeasurables(
                                                          newMeasurables
                                                              .toMap());

                                                if (addingTask > 0) {
                                                  _showSnackBar(Text(
                                                    'Todo is inserted successfully',
                                                    style: GoogleFonts.ubuntu(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ));
                                                }

                                                _clearFields();
                                              }
                                            },
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
                                            onPressed: () async {
                                              var todos = await _databaseManager
                                                  .getAllTask();
                                              print(todos);
                                              _clearFields();
                                              _formKey.currentState.reset();
                                            },
                                            child: Text(
                                              "Clear",
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
