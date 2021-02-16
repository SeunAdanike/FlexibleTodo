import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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

  var _categoriesController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 38.0,
          left: 15,
          right: 0,
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
                right: 8.0,
                top: 18.0,
              ),
              child: Card(
                color: Colors.white,
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
                        width: MediaQuery.of(context).size.width * 0.4,
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
                            'Category',
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
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                isGradual
                                    ? Row(
                                        children: [
                                          RaisedButton(
                                            color:
                                                Theme.of(context).primaryColor,
                                            shape: StadiumBorder(),
                                            onPressed: () {},
                                            child: Padding(
                                              padding: const EdgeInsets.only(
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
                                            color:
                                                Theme.of(context).primaryColor,
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
                                          color: Theme.of(context).primaryColor,
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
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        shape: StadiumBorder(),
                                      )
                                    : Row(
                                        children: [
                                          RaisedButton(
                                            color:
                                                Theme.of(context).primaryColor,
                                            shape: StadiumBorder(),
                                            onPressed: () {},
                                            child: Padding(
                                              padding: const EdgeInsets.only(
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
                                            color:
                                                Theme.of(context).primaryColor,
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
                          Column(
                            children: [
                              Text(
                                'Due date',
                                style: GoogleFonts.ubuntu(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
