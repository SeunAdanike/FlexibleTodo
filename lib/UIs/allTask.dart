import 'package:flexibletodo/models/dummyTask.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllTask extends StatefulWidget {
  @override
  _AllTaskState createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  double sizeMenu = 30, sizeAddTask = 30, sizeProfile = 30, sizeSetting = 30;
  double sizeHome = 36;
  bool isMenu = false, isAddTask = false, isProfile = false, isSettings = false;
  bool isHome = true;
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AllTask(),
                      ),
                    );
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
            Divider(),
            Text(
              'All Tasks',
              style: GoogleFonts.ubuntu(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
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
                      onTap: () {},
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
                                        DUMMY_TASK[index].title,
                                        style: GoogleFonts.ubuntu(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        DUMMY_TASK[index].category,
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
                                        DUMMY_TASK[index].isFinished
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
                                        DUMMY_TASK[index].isFinished
                                            ? 'Completed'
                                            : 'Due on ${DUMMY_TASK[index].todoDueDate}',
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
                                      Icons.delete,
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
                itemCount: DUMMY_TASK.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
