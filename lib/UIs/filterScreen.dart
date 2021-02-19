import 'package:flexibletodo/UIs/details.dart';
import 'package:flexibletodo/models/dummyTask.dart';
import 'package:flexibletodo/models/task.dart';
import 'package:flexibletodo/widgets/drawer.dart';
import 'package:flexibletodo/widgets/edgeDesign.dart';
import 'package:flexibletodo/widgets/menubar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterHelper extends StatefulWidget {
  final String field;
  FilterHelper({@required this.field});
  @override
  _FilterHelperState createState() => _FilterHelperState();
}

class _FilterHelperState extends State<FilterHelper> {
  List<Task> _alltask = List<Task>();
  List<Task> _fetchedTask = List<Task>();
  List<Task> _categoriesTask = List<Task>();

  _placeGetter() {
    _alltask = DUMMY_TASK.toList();
    for (int i = 0; i < _alltask.length; i++) {
      if (widget.field == 'Pending') {
        if (!_alltask[i].isFinished) _fetchedTask.add(_alltask[i]);
      }
      if (widget.field == 'Completed') {
        if (_alltask[i].isFinished) _fetchedTask.add(_alltask[i]);
      }
      if (_alltask[i].category == widget.field)
        _fetchedTask.add(
          _alltask[i],
        );
    }
  }

  @override
  void initState() {
    _placeGetter();
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
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TodoDetailsScreen(
                                      task: _fetchedTask[index],
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
