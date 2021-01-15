import 'dart:ui';

import 'package:circular_check_box/circular_check_box.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tractiv/database.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import 'models/list.dart';

class MainTask extends StatefulWidget {
  @override
  _MainTaskState createState() => _MainTaskState();
}

class _MainTaskState extends State<MainTask> {
  final fColor = const Color(0x4285F4);
  DatabaseHelper _dbhelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final fColor = const Color(0xFF4285F4);
    final black = const Color(0xFF171717);
    int last;

    DateHelper _dhelper = DateHelper();
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            child: Container(
              height: 140,
              width: width,
              color: Colors.grey.shade800.withOpacity(0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: Container(
                      height: 140,
                      width: 140,
                      color: fColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateTime.now().toString().substring(8, 10),
                                style: TextStyle(
                                    fontFamily: "Gotham",
                                    fontSize: 64,
                                    color: Colors.white),
                              ),
                              Text(
                                _dhelper
                                    .getmonth(DateTime.now()
                                        .toString()
                                        .substring(5, 7))
                                    .substring(0, 3)
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontFamily: "Gotham",
                                  fontSize: 24,
                                  color: Colors.black.withOpacity(0.2),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 100,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                _dhelper.getWeek(DateTime.now()).toUpperCase(),
                                style: TextStyle(
                                    fontFamily: "Gotham",
                                    //fontSize: 30,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                        child: Text("35 \nTasks",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Gotham",
                              fontSize: 23,
                              color: black,
                            ))),
                  ),
                  Container(
                    height: 80,
                    child: Image.asset('assets/Callendar.png'),
                  ),
                  SizedBox(width: 10)
                ],
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            initialData: [],
            future: _dbhelper.getTasks(),
            builder: (context, snapshot) {
              last = snapshot.data.length;
              return snapshot.data.length != 0
                  ? (ListView.builder(
                      itemCount: snapshot.data.length + 1,
                      itemBuilder: (context, index) {
                        return index < last
                            ? TaskWidget(
                                id: snapshot.data[index].id,
                                title: snapshot.data[index].title,
                                index: index,
                                line: false,
                                line2: false,
                                itemlength: snapshot.data.length,
                                day: snapshot.data[index].day,
                                month: snapshot.data[index].month,
                                year: snapshot.data[index].year,
                                hour: snapshot.data[index].hour,
                                minute: snapshot.data[index].minute,
                                weekday: snapshot.data[index].weekday,
                              )
                            : Container(height: 40, width: 100);
                      }))
                  : Container(
                      height: height / 2,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: 100,
                              child: Image.asset('assets/Cat-sleep.png')),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Done for today!",
                            style: TextStyle(
                                fontFamily: "Averta",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: fColor),
                          )
                        ],
                      )));
            },
          )),
        ],
      ),
    );
  }
}

class TaskWidget extends StatefulWidget {
  int id;
  String title;
  String day;
  String month;
  String year;
  String weekday;
  String hour;
  String minute;
  int index;
  bool line;
  int itemlength;
  bool line2;

  TaskWidget(
      {Key key,
      this.id,
      this.title,
      this.day,
      this.month,
      this.year,
      this.weekday,
      this.hour,
      this.minute,
      this.index,
      this.itemlength,
      this.line2,
      this.line})
      : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool _isEditingText = false;
  static TextEditingController _editingController;
  CalendarController _controller;
  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: widget.title);
    _controller = CalendarController();
  }

  @override
  void dispose() {
    //_editingController.dispose();
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final fColor = const Color(0xFF4285F4);
    final black = const Color(0xFF171717);
    final yellow = const Color(0xFFffbe0b);
    bool radio = false;
    double _opacity = 0.3;
    DateHelper _dhelper = DateHelper();
    double _error2 = 0.0;
    double _error1 = 0.0;
    double _error3 = 0.0;

    if (widget.title != null) {
      return InkWell(
        onTap: () => showAnimatedDialog(
            barrierDismissible: true,
            context: context,
            animationType: DialogTransitionType.scale,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 400),
            builder: (BuildContext context) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                          child: Positioned(
                            bottom: 100,
                            child: Container(
                              color: Colors.white,
                              width: width - 4,
                              height: 530,
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        color: Colors.transparent,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 200,
                                                child: TextField(
                                                  style: TextStyle(
                                                    fontFamily: "Averta",
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.bold,
                                                    color: fColor,
                                                  ),
                                                  controller:
                                                      _editingController,
                                                  onChanged: (value) async {
                                                    setState(() {
                                                      if (value != "") {
                                                        setState(() {
                                                          _error1 = 0.0;
                                                        });
                                                        DatabaseHelper
                                                            _dbhelper =
                                                            DatabaseHelper();
                                                        widget.title = value;
                                                        _isEditingText = false;
                                                        _dbhelper
                                                            .updateTaskTitle(
                                                                widget.id,
                                                                widget.title);
                                                      } else {
                                                        setState(() {
                                                          _error1 = 1.0;
                                                        });
                                                      }
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    //contentPadding: EdgeInsets.all(8),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  this.setState(() {
                                                    DatabaseHelper _dbhelper =
                                                        DatabaseHelper();
                                                    _dbhelper
                                                        .deleteTask(widget.id);
                                                    widget.line = true;
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              14.0)),
                                                  child: Container(
                                                    height: 32,
                                                    width: 32,
                                                    color: Colors.grey.shade300
                                                        .withOpacity(0.5),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.delete_outline,
                                                        color: Colors.white,
                                                        size: 26,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      AnimatedOpacity(
                                        duration: Duration(milliseconds: 120),
                                        opacity: _error1,
                                        child: Text(
                                          "(Title should not be empty)",
                                          style: TextStyle(
                                              fontFamily: "Averta",
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12,
                                              color: Colors.red),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
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
                                            duration:
                                                Duration(milliseconds: 120),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(24.0)),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10.0, sigmaY: 10.0),
                                          child: Container(
                                            color: fColor.withOpacity(0.1),
                                            child: Center(
                                              child: TableCalendar(
                                                initialSelectedDay: widget
                                                            .hour !=
                                                        "null"
                                                    ? DateTime(
                                                        int.parse(widget.year),
                                                        int.parse(widget.month),
                                                        int.parse(widget.day),
                                                        int.parse(widget.hour),
                                                        int.parse(
                                                            widget.minute))
                                                    : DateTime(
                                                        int.parse(widget.year),
                                                        int.parse(widget.month),
                                                        int.parse(widget.day),
                                                        01,
                                                        20),
                                                daysOfWeekStyle:
                                                    DaysOfWeekStyle(
                                                        weekdayStyle: TextStyle(
                                                            fontFamily:
                                                                "Averta",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: fColor),
                                                        weekendStyle:
                                                            TextStyle(
                                                                fontFamily:
                                                                    "Averta",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: yellow)),
                                                calendarStyle: CalendarStyle(
                                                    contentDecoration:
                                                        BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            18))),
                                                    weekdayStyle: TextStyle(
                                                        fontFamily: "Gotham",
                                                        color: fColor),
                                                    selectedStyle: TextStyle(
                                                        fontFamily: "Gotham",
                                                        color: Colors.white),
                                                    selectedColor: fColor,
                                                    todayColor:
                                                        fColor.withOpacity(0.3),
                                                    todayStyle: TextStyle(
                                                        fontFamily: "Gotham",
                                                        color: Colors.white),
                                                    weekendStyle: TextStyle(
                                                      fontFamily: "Gotham",
                                                      color: yellow,
                                                    )),
                                                headerStyle: HeaderStyle(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    28))),
                                                    leftChevronIcon: Icon(
                                                        Icons.chevron_left,
                                                        color: fColor),
                                                    rightChevronIcon: Icon(
                                                        Icons.chevron_right,
                                                        color: fColor),
                                                    titleTextStyle: TextStyle(
                                                        fontFamily: "Averta",
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: fColor),
                                                    centerHeaderTitle: true,
                                                    formatButtonVisible: false),
                                                initialCalendarFormat:
                                                    CalendarFormat.week,
                                                availableCalendarFormats: {
                                                  CalendarFormat.week: "Week"
                                                },
                                                calendarController: _controller,
                                                onDaySelected:
                                                    (day, events, holidays) {
                                                  if (int.parse(day.toString().substring(8, 10)) >=
                                                          int.parse(DateTime.now()
                                                              .toString()
                                                              .substring(
                                                                  8, 10)) &&
                                                      int.parse(day.toString().substring(5, 7)) >=
                                                          int.parse(DateTime.now()
                                                              .toString()
                                                              .substring(
                                                                  5, 7)) &&
                                                      int.parse(day.toString().substring(0, 4)) >=
                                                          int.parse(
                                                              DateTime.now()
                                                                  .toString()
                                                                  .substring(
                                                                      0, 4))) {
                                                    setState(() {
                                                      _error2 = 0.0;
                                                    });
                                                    DatabaseHelper _dbhelper =
                                                        DatabaseHelper();
                                                    widget.year = day
                                                        .toString()
                                                        .substring(0, 4);
                                                    widget.month = day
                                                        .toString()
                                                        .substring(5, 7);
                                                    widget.day = day
                                                        .toString()
                                                        .substring(8, 10);
                                                    _dbhelper.updateday(
                                                        widget.id, widget.day);
                                                    _dbhelper.updatemonth(
                                                        widget.id,
                                                        widget.month);
                                                    _dbhelper.updateyear(
                                                        widget.id, widget.year);
                                                  } else {
                                                    setState(() {
                                                      _error2 = 1.0;
                                                    });
                                                  }
                                                  ;
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter setState) {
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Theme(
                                                  data: ThemeData(
                                                      unselectedWidgetColor:
                                                          fColor.withOpacity(
                                                              0.3)),
                                                  child: CircularCheckBox(
                                                      value: radio,
                                                      disabledColor:
                                                          Colors.grey.shade200,
                                                      activeColor: fColor,
                                                      onChanged: (bool value) {
                                                        setState(() {
                                                          radio = value;
                                                          _opacity =
                                                              _opacity == 0.3
                                                                  ? 1.0
                                                                  : 0.3;
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
                                                      _opacity = _opacity == 0.3
                                                          ? 1.0
                                                          : 0.3;
                                                    });
                                                  },
                                                  child: AnimatedOpacity(
                                                    duration: Duration(
                                                        milliseconds: 120),
                                                    opacity: _opacity,
                                                    child: Text(
                                                      "Time",
                                                      style: TextStyle(
                                                        fontFamily: "Averta",
                                                        fontSize: 14,
                                                        color: fColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                AnimatedOpacity(
                                                  duration: Duration(
                                                      milliseconds: 120),
                                                  opacity: _error3,
                                                  child: Text(
                                                    "(Swipe Up/Down to change time)",
                                                    style: TextStyle(
                                                        fontFamily: "Averta",
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            AnimatedOpacity(
                                              duration:
                                                  Duration(milliseconds: 120),
                                              opacity: _opacity,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (radio) {
                                                      _error3 = _error3 == 0.0
                                                          ? 1.0
                                                          : 0.0;
                                                    } else {
                                                      radio = true;
                                                      _opacity = _opacity == 0.3
                                                          ? 1.0
                                                          : 0.3;
                                                    }
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(36),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      36)),
                                                      child: Container(
                                                        height: 120,
                                                        width: 100,
                                                        color: fColor
                                                            .withOpacity(0.08),
                                                        child: Center(
                                                          child:
                                                              ListWheelScrollView
                                                                  .useDelegate(
                                                            itemExtent: 120,
                                                            squeeze: 0.2,
                                                            physics:
                                                                FixedExtentScrollPhysics(),
                                                            diameterRatio: 10,
                                                            magnification: 1.5,
                                                            onSelectedItemChanged:
                                                                (value) {
                                                              widget.hour =
                                                                  hours[value];
                                                            },
                                                            childDelegate:
                                                                ListWheelChildBuilderDelegate(
                                                                    builder:
                                                                        (context,
                                                                            index) {
                                                              if (index < 0 ||
                                                                  index >
                                                                      (hours.length -
                                                                          1)) {
                                                                return null;
                                                              }
                                                              return Container(
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                hours[index],
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Gotham",
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
                                                      color: fColor
                                                          .withOpacity(0.08),
                                                      child: Center(
                                                        child: Text(
                                                          ":",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Averta",
                                                            fontSize: 48,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: fColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ), //first
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(36),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          36)),
                                                      child: Container(
                                                        height: 120,
                                                        width: 100,
                                                        color: fColor
                                                            .withOpacity(0.08),
                                                        child: Center(
                                                          child:
                                                              ListWheelScrollView
                                                                  .useDelegate(
                                                            itemExtent: 120,
                                                            squeeze: 0.2,
                                                            physics:
                                                                FixedExtentScrollPhysics(),
                                                            diameterRatio: 4,
                                                            magnification: 1.5,
                                                            onSelectedItemChanged:
                                                                (value) {
                                                              widget.minute =
                                                                  mins[value];
                                                            },
                                                            childDelegate:
                                                                ListWheelChildBuilderDelegate(
                                                                    builder:
                                                                        (context,
                                                                            index) {
                                                              if (index < 0 ||
                                                                  index >
                                                                      (mins.length -
                                                                          1)) {
                                                                return null;
                                                              }
                                                              return Container(
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                mins[index],
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Gotham",
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
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  14.0)),
                                                      child: Container(
                                                        height: 120,
                                                        width: 70,
                                                        color: Colors
                                                            .grey.shade800
                                                            .withOpacity(0),
                                                        child: Center(
                                                          child:
                                                              ListWheelScrollView
                                                                  .useDelegate(
                                                            itemExtent: 40,
                                                            squeeze: 0.2,
                                                            physics:
                                                                FixedExtentScrollPhysics(),
                                                            diameterRatio: 100,
                                                            magnification: 1.5,
                                                            onSelectedItemChanged:
                                                                (value) {
                                                              widget.weekday =
                                                                  type[value];
                                                            },
                                                            childDelegate:
                                                                ListWheelChildBuilderDelegate(
                                                                    builder:
                                                                        (context,
                                                                            index) {
                                                              if (index < 0 ||
                                                                  index >
                                                                      (type.length -
                                                                          1)) {
                                                                return null;
                                                              }
                                                              return Container(
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                type[index],
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Gotham",
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
                                          ],
                                        );
                                      }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              height: 60,
                                              child: Image.asset(
                                                  'assets/Big-pencil.png')),
                                          SizedBox(width: 10),
                                          InkWell(
                                            onTap: () {
                                              this.setState(() {
                                                DatabaseHelper _dbhelper =
                                                    DatabaseHelper();
                                                _dbhelper.deleteTask(widget.id);
                                                widget.line2 = true;
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(14.0)),
                                              child: Container(
                                                color: Colors.green,
                                                height: 36,
                                                width: 100,
                                                child: Center(
                                                  child: Text(
                                                    "Mark as Done",
                                                    style: TextStyle(
                                                      fontFamily: "Averta",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              this.setState(() {
                                                Navigator.pop(context);
                                              });
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
                                                    "Done",
                                                    style: TextStyle(
                                                      fontFamily: "Averta",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                      Text(
                                        "(Tap on items to edit)",
                                        style: TextStyle(
                                            fontFamily: "Averta",
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            }),
        child: !widget.line
            ? !widget.line2
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: Container(
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(widget.day,
                                    style: TextStyle(
                                      fontFamily: "Gotham",
                                      fontSize: 28,
                                      color: fColor,
                                    )),
                              ),
                              Container(
                                child: Text(
                                    _dhelper
                                        .getmonth(widget.month)
                                        .substring(0, 3)
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: "Gotham",
                                      fontSize: 16,
                                      color: fColor,
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0)),
                            child: Container(
                              height: 60,
                              width: 2,
                              color: yellow,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: width - 112,
                                  child: Text(
                                    widget.title,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontFamily: "Averta",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: black),
                                  )),
                              SizedBox(
                                height: 14,
                              ),
                              Container(
                                child: Center(
                                  child: (widget.hour != "null" &&
                                          widget.minute != "null" &&
                                          widget.weekday != "null")
                                      ? Text(
                                          "${widget.hour}:${widget.minute} ${widget.weekday}",
                                          style: TextStyle(
                                              fontFamily: "Gotham",
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        )
                                      : SizedBox(
                                          height: 2,
                                        ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 2,
                          ),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            child: Container(
                                height: 24,
                                width: 24,
                                color: Colors.green,
                                child: Center(
                                  child: Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0)),
                            child: Container(
                              height: 60,
                              width: 2,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: width - 112,
                                  child: Text(
                                    widget.title,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontFamily: "Averta",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  )),
                              SizedBox(
                                height: 14,
                              ),
                              Container(
                                child: Center(
                                  child: (widget.hour != "null" &&
                                          widget.minute != "null" &&
                                          widget.weekday != "null")
                                      ? Text(
                                          "${widget.hour}:${widget.minute} ${widget.weekday}",
                                          style: TextStyle(
                                              fontFamily: "Gotham",
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        )
                                      : SizedBox(
                                          height: 2,
                                        ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
            : Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: Container(
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(widget.day,
                                style: TextStyle(
                                  fontFamily: "Gotham",
                                  fontSize: 28,
                                  color: Colors.grey.shade300,
                                )),
                          ),
                          Container(
                            child: Text(
                                _dhelper
                                    .getmonth(widget.month)
                                    .substring(0, 3)
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontFamily: "Gotham",
                                  fontSize: 16,
                                  color: Colors.grey.shade300,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        child: Container(
                          height: 60,
                          width: 2,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: width - 112,
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  fontFamily: "Averta",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade300,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              )),
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            child: Center(
                              child: (widget.hour != "null" &&
                                      widget.minute != "null" &&
                                      widget.weekday != "null")
                                  ? Text(
                                      "${widget.hour}:${widget.minute} ${widget.weekday}",
                                      style: TextStyle(
                                          fontFamily: "Gotham",
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade300),
                                    )
                                  : SizedBox(
                                      height: 22,
                                    ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          DatabaseHelper _dbhelper = DatabaseHelper();
          _dbhelper.deleteTask(widget.id);
        },
        child: Container(height: 100, width: 20, child: Text("Invalid ")),
      );
    }
  }
}
