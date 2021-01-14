/*import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:tractiv/database.dart';
import 'package:tractiv/models/task.dart';

class MenuWidget extends StatefulWidget {
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  CalendarController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final fColor = const Color(0x4285F4);
    DateTime now = DateTime.now();

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(13.0)),
              child: Container(
                color: Color(0x4285F4).withOpacity(1),
                width: width - 86,
                height: 46,
                child: Center(
                  child: Text(
                    'Create New Task',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            child: new BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                color: Colors.grey.shade200.withOpacity(0.5),
                width: width - 28,
                height: height / 2 + 120,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            color: Colors.white.withOpacity(0.7),
                            child: Center(
                              child: TextField(
                                onSubmitted: (value) async {
                                  if (value != "") {
                                    DatabaseHelper _dbhelper = DatabaseHelper();
                                    Task _newTask = Task(title: value);
                                    await _dbhelper.insertTask(_newTask);
                                  }
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(18),
                                    hintText: "Enter Task Title"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            color: fColor.withOpacity(0.1),
                            child: Center(
                              child: TableCalendar(
                                initialCalendarFormat: CalendarFormat.week,
                                availableCalendarFormats: {
                                  CalendarFormat.week: "Week"
                                },
                                headerStyle:
                                    HeaderStyle(formatButtonVisible: false),
                                calendarController: _controller,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                child: Container(
                                  height: 10,
                                  width: 14,
                                  color: fColor.withOpacity(0.1),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      size: 4,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                                child: Container(
                                  height: 80,
                                  width: 250,
                                  color: Colors.grey.shade800.withOpacity(0.04),
                                  child: Center(
                                    child: TimePickerSpinner(
                                      is24HourMode: false,
                                      normalTextStyle: TextStyle(
                                          fontSize: 24, color: Colors.black),
                                      highlightedTextStyle: TextStyle(
                                          fontSize: 24, color: Colors.blue),
                                      spacing: 50,
                                      itemHeight: 80,
                                      isForce2Digits: true,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                child: Container(
                                  height: 10,
                                  width: 14,
                                  color: fColor.withOpacity(0.1),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      size: 4,
                                    ),
                                  ),
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
          ),
          RaisedButton(onPressed: () {
            showBottomMenu = false;
          })
        ],
      ),
    );
  }
}*/
