import 'dart:ui';
import 'package:tractiv/main_task.dart';
import 'package:tractiv/models/list.dart';
import 'package:flutter/material.dart';
import 'package:tractiv/menu.dart';
//This is from menu file
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tractiv/database.dart';
import 'package:tractiv/models/task.dart';
import 'package:circular_check_box/circular_check_box.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

bool showBottomMenu = false;

class _TaskPageState extends State<TaskPage> {
  //double height= MediaQuery.of(context).size.height;
  CalendarController _controller;
  TextEditingController _editingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editingController = TextEditingController();
    _controller = CalendarController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _editingController.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final fColor = const Color(0xFF4285F4);
    DateTime now = DateTime.now();
    String title;
    String daye;
    String month;
    String year;
    String hour = "01";
    String minute = "00";
    String weekday = "AM";
    bool radio = false;
    double _opacity = 0.3;
    double _error = 0.0;
    double _error1 = 0.0;
    double _error2 = 0.0;
    double _error3 = 0.0;

    return Container(
      child: Stack(children: [
        MainTask(),
        AnimatedPositioned(
            curve: Curves.bounceInOut,
            duration: Duration(milliseconds: 160),
            left: 0,
            bottom: (showBottomMenu)
                ? (10)
                : (-(height / 2) - 80 - 54 - 80 - 80 - 90),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      this.setState(() {
                        showBottomMenu = true;
                      });
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                        child: Container(
                          color: Color(0x4285F4).withOpacity(1),
                          width: width - 86,
                          height: 46,
                          child: Center(
                            child: Text(
                              'CREATE NEW TASK',
                              style: TextStyle(
                                  fontFamily: 'Gotham',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 280,
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                        child: new BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                          child: Container(
                            color: Colors.grey.shade200.withOpacity(0.5),
                            width: width - 28,
                            height: height / 2 + 24 + 90 + 10,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Task",
                                        style: TextStyle(
                                          fontFamily: "Averta",
                                          fontSize: 14,
                                          color: fColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      AnimatedOpacity(
                                        duration: Duration(milliseconds: 120),
                                        opacity: _error,
                                        child: Text(
                                          "(Task field cannot be empty)",
                                          style: TextStyle(
                                              fontFamily: "Averta",
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12,
                                              color: Colors.red),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          this.setState(() {
                                            showBottomMenu = false;
                                          });
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(14.0)),
                                          child: Container(
                                            height: 32,
                                            width: 32,
                                            color: Colors.grey.shade300
                                                .withOpacity(0.5),
                                            child: Center(
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 26,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14.0)),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10.0, sigmaY: 10.0),
                                      child: Container(
                                        color: Colors.white.withOpacity(0.7),
                                        child: Center(
                                          child: TextField(
                                            controller: _editingController,
                                            style: TextStyle(
                                                fontFamily: "Averta",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black),
                                            enableSuggestions: true,
                                            onChanged: (value) {
                                              title = value;

                                              print(title);
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.all(18),
                                              hintText: "Enter Task Title",
                                              hintStyle: TextStyle(
                                                  fontFamily: "Averta",
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12,
                                                  color: Colors.grey.shade300),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Date",
                                        style: TextStyle(
                                          fontFamily: "Averta",
                                          fontSize: 14,
                                          color: fColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      AnimatedOpacity(
                                        duration: Duration(milliseconds: 120),
                                        opacity: _error2,
                                        child: Text(
                                          "(Please enter a valid Date)",
                                          style: TextStyle(
                                              fontFamily: "Averta",
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12,
                                              color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14.0)),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10.0, sigmaY: 10.0),
                                      child: Container(
                                        color: fColor.withOpacity(0.1),
                                        child: Center(
                                          child: TableCalendar(
                                            initialCalendarFormat:
                                                CalendarFormat.week,
                                            availableCalendarFormats: {
                                              CalendarFormat.week: "Week"
                                            },
                                            headerStyle: HeaderStyle(
                                                formatButtonVisible: false),
                                            calendarController: _controller,
                                            onDaySelected:
                                                (day, events, holidays) {
                                              if (int.parse(day
                                                          .toString()
                                                          .substring(8, 10)) >=
                                                      int.parse(DateTime.now()
                                                          .toString()
                                                          .substring(8, 10)) &&
                                                  int.parse(day.toString().substring(5, 7)) >=
                                                      int.parse(DateTime.now()
                                                          .toString()
                                                          .substring(5, 7)) &&
                                                  int.parse(day.toString().substring(0, 4)) >=
                                                      int.parse(DateTime.now()
                                                          .toString()
                                                          .substring(0, 4))) {
                                                year = day
                                                    .toString()
                                                    .substring(0, 4);
                                                month = day
                                                    .toString()
                                                    .substring(5, 7);
                                                daye = day
                                                    .toString()
                                                    .substring(8, 10);
                                                setState(() {
                                                  _error2 = 0.0;
                                                });
                                              } else {
                                                setState(() {
                                                  _error2 = 1.0;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Theme(
                                        data: ThemeData(
                                            unselectedWidgetColor:
                                                fColor.withOpacity(0.3)),
                                        child: CircularCheckBox(
                                            value: radio,
                                            disabledColor: Colors.grey.shade200,
                                            activeColor: fColor,
                                            onChanged: (bool value) {
                                              setState(() {
                                                radio = value;
                                                _opacity =
                                                    _opacity == 0.3 ? 1.0 : 0.3;
                                              });
                                            }),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            radio = !radio;
                                            _opacity =
                                                _opacity == 0.3 ? 1.0 : 0.3;
                                          });
                                        },
                                        child: AnimatedOpacity(
                                          duration: Duration(milliseconds: 120),
                                          opacity: _opacity,
                                          child: Text(
                                            "Time",
                                            style: TextStyle(
                                              fontFamily: "Averta",
                                              fontSize: 14,
                                              color: fColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      AnimatedOpacity(
                                        duration: Duration(milliseconds: 120),
                                        opacity: _error1,
                                        child: Text(
                                          "(Swipe Up/Down to change time)",
                                          style: TextStyle(
                                              fontFamily: "Averta",
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  AnimatedOpacity(
                                    duration: Duration(milliseconds: 120),
                                    opacity: _opacity,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (radio) {
                                            _error1 =
                                                _error1 == 0.0 ? 1.0 : 0.0;
                                          } else {
                                            radio = true;
                                            _opacity =
                                                _opacity == 0.3 ? 1.0 : 0.3;
                                          }
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(36),
                                                bottomLeft:
                                                    Radius.circular(36)),
                                            child: Container(
                                              height: 120,
                                              width: 100,
                                              color: fColor.withOpacity(0.08),
                                              child: Center(
                                                child: ListWheelScrollView
                                                    .useDelegate(
                                                  itemExtent: 120,
                                                  squeeze: 0.2,
                                                  physics:
                                                      FixedExtentScrollPhysics(),
                                                  diameterRatio: 10,
                                                  magnification: 1.5,
                                                  onSelectedItemChanged:
                                                      (value) {
                                                    hour = hours[value];
                                                    print(hour);
                                                  },
                                                  childDelegate:
                                                      ListWheelChildBuilderDelegate(
                                                          builder:
                                                              (context, index) {
                                                    if (index < 0 ||
                                                        index >
                                                            (hours.length -
                                                                1)) {
                                                      return null;
                                                    }
                                                    return Container(
                                                        child: Center(
                                                            child: Text(
                                                      hours[index],
                                                      style: TextStyle(
                                                        fontFamily: "Gotham",
                                                        fontSize: 48,
                                                        color: fColor,
                                                      ),
                                                    )));
                                                  }),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 120,
                                            color: fColor.withOpacity(0.08),
                                            child: Center(
                                              child: Text(
                                                ":",
                                                style: TextStyle(
                                                  fontFamily: "Averta",
                                                  fontSize: 48,
                                                  fontWeight: FontWeight.bold,
                                                  color: fColor,
                                                ),
                                              ),
                                            ),
                                          ), //first
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(36),
                                                bottomRight:
                                                    Radius.circular(36)),
                                            child: Container(
                                              height: 120,
                                              width: 100,
                                              color: fColor.withOpacity(0.08),
                                              child: Center(
                                                child: ListWheelScrollView
                                                    .useDelegate(
                                                  itemExtent: 120,
                                                  squeeze: 0.2,
                                                  physics:
                                                      FixedExtentScrollPhysics(),
                                                  diameterRatio: 4,
                                                  magnification: 1.5,
                                                  onSelectedItemChanged:
                                                      (value) {
                                                    minute = mins[value];
                                                    print(minute);
                                                  },
                                                  childDelegate:
                                                      ListWheelChildBuilderDelegate(
                                                          builder:
                                                              (context, index) {
                                                    if (index < 0 ||
                                                        index >
                                                            (mins.length - 1)) {
                                                      return null;
                                                    }
                                                    return Container(
                                                        child: Center(
                                                            child: Text(
                                                      mins[index],
                                                      style: TextStyle(
                                                        fontFamily: "Gotham",
                                                        fontSize: 48,
                                                        color: fColor,
                                                      ),
                                                    )));
                                                  }),
                                                ),
                                              ),
                                            ),
                                          ), //second
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(14.0)),
                                            child: Container(
                                              height: 120,
                                              width: 70,
                                              color: Colors.grey.shade800
                                                  .withOpacity(0),
                                              child: Center(
                                                child: ListWheelScrollView
                                                    .useDelegate(
                                                  itemExtent: 40,
                                                  squeeze: 0.2,
                                                  physics:
                                                      FixedExtentScrollPhysics(),
                                                  diameterRatio: 100,
                                                  magnification: 1.5,
                                                  onSelectedItemChanged:
                                                      (value) {
                                                    weekday = type[value];
                                                    print(weekday);
                                                  },
                                                  childDelegate:
                                                      ListWheelChildBuilderDelegate(
                                                          builder:
                                                              (context, index) {
                                                    if (index < 0 ||
                                                        index >
                                                            (type.length - 1)) {
                                                      return null;
                                                    }
                                                    return Container(
                                                        child: Center(
                                                            child: Text(
                                                      type[index],
                                                      style: TextStyle(
                                                        fontFamily: "Gotham",
                                                        fontSize: 28,
                                                        color: fColor,
                                                      ),
                                                    )));
                                                  }),
                                                ),
                                              ),
                                            ),
                                          ), //This is the third one
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          height: 60,
                                          child:
                                              Image.asset('assets/Plants.png')),
                                      InkWell(
                                        splashColor:
                                            Colors.grey.withOpacity(0.4),
                                        onTap: () {
                                          print(_editingController.text);

                                          DatabaseHelper _dbhelper =
                                              DatabaseHelper();
                                          if (_editingController.text != "") {
                                            if (daye != null) {
                                              if (radio) {
                                                this.setState(() {
                                                  Task _newTask = Task(
                                                      title: _editingController
                                                          .text,
                                                      year: year,
                                                      month: month,
                                                      day: daye,
                                                      hour: hour,
                                                      minute: minute,
                                                      weekday: weekday);
                                                  _dbhelper
                                                      .insertTask(_newTask);
                                                  showBottomMenu = false;
                                                  _editingController.text = "";
                                                });
                                              } else {
                                                this.setState(() {
                                                  Task _newTask = Task(
                                                      title: _editingController
                                                          .text,
                                                      year: year,
                                                      month: month,
                                                      day: daye,
                                                      hour: "null",
                                                      minute: "null",
                                                      weekday: "null");
                                                  _dbhelper
                                                      .insertTask(_newTask);
                                                  showBottomMenu = false;
                                                  _editingController.text = "";
                                                });
                                              }
                                            } else {
                                              if (radio) {
                                                this.setState(() {
                                                  Task _newTask = Task(
                                                      title: _editingController
                                                          .text,
                                                      year: DateTime.now()
                                                          .toString()
                                                          .substring(0, 4),
                                                      month: DateTime.now()
                                                          .toString()
                                                          .substring(5, 7),
                                                      day: DateTime.now()
                                                          .toString()
                                                          .substring(8, 10),
                                                      hour: hour,
                                                      minute: minute,
                                                      weekday: weekday);
                                                  _dbhelper
                                                      .insertTask(_newTask);
                                                  showBottomMenu = false;
                                                  _editingController.text = "";
                                                });
                                              } else {
                                                this.setState(() {
                                                  Task _newTask = Task(
                                                      title: _editingController
                                                          .text,
                                                      year: DateTime.now()
                                                          .toString()
                                                          .substring(0, 4),
                                                      month: DateTime.now()
                                                          .toString()
                                                          .substring(5, 7),
                                                      day: DateTime.now()
                                                          .toString()
                                                          .substring(8, 10),
                                                      hour: "null",
                                                      minute: "null",
                                                      weekday: "null");
                                                  _dbhelper
                                                      .insertTask(_newTask);
                                                  showBottomMenu = false;
                                                  _editingController.text = "";
                                                });
                                              }
                                            }
                                          } else {
                                            setState(() {
                                              _error = 1.0;
                                            });
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(14.0)),
                                          child: Container(
                                            color: fColor,
                                            height: 36,
                                            width: 100,
                                            child: Center(
                                              child: Text(
                                                "Create",
                                                style: TextStyle(
                                                  fontFamily: "Averta",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            )),
        Column(
          children: [
            Container(
              height: 36,
              color: Colors.white,
            ),
            Container(
              alignment: Alignment.topLeft,
              height: 36,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(
                  'today',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Gotham',
                    fontSize: 36,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
