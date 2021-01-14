import 'package:flutter/material.dart';

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  DateTime now = DateTime.now();
  int hour = 0;
  int minute = 0;
  String type = 'AM';
  bool radio = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        children: [
          SizedBox(height: 24),
          Container(
            alignment: Alignment.topLeft,
            height: 80,
            child: Text(
              'all tasks',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Gotham',
                fontSize: 36,
                color: Colors.black,
              ),
            ),
          ),
          Checkbox(
              value: radio,
              activeColor: Colors.blue,
              onChanged: (bool value) {
                setState(() {
                  radio = value;
                });
              }),
          Container(
            child: Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        this.setState(() {
                          if (hour < 13 && hour > 0) {
                            hour = hour - 1;
                          }
                        });
                      },
                      child: Container(
                        child: Center(
                          child: Icon(
                            Icons.arrow_drop_up,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade800.withOpacity(0.2),
                      height: 90,
                      width: 80,
                      child: Center(
                        child: Text('$hour'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        this.setState(() {
                          if (hour >= 0 && hour < 12) {
                            hour = hour + 1;
                          }
                        });
                      },
                      child: Container(
                        child: Center(
                          child: Icon(
                            Icons.arrow_drop_down,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ), //This is the first Column
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        this.setState(() {
                          if (minute < 60 && minute > 0) {
                            minute = minute - 1;
                          }
                        });
                      },
                      child: Container(
                        child: Center(
                          child: Icon(
                            Icons.arrow_drop_up,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade800.withOpacity(0.2),
                      height: 90,
                      width: 80,
                      child: Center(
                        child: Text('$minute'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        this.setState(() {
                          if (minute >= 0 && minute < 60) {
                            minute = minute + 1;
                          }
                        });
                      },
                      child: Container(
                        child: Center(
                          child: Icon(
                            Icons.arrow_drop_down,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ), //This is the second column
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        this.setState(() {
                          if (type == 'AM') {
                            type = 'PM';
                          } else if (type == 'PM') {
                            type = 'AM';
                          }
                        });
                      },
                      child: Container(
                        child: Center(
                          child: Icon(
                            Icons.arrow_drop_up,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade800.withOpacity(0.2),
                      height: 90,
                      width: 80,
                      child: Center(
                        child: Text('$type'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        this.setState(() {
                          if (type == 'AM') {
                            type = 'PM';
                          } else if (type == 'PM') {
                            type = 'AM';
                          }
                        });
                      },
                      child: Container(
                        child: Center(
                          child: Icon(
                            Icons.arrow_drop_down,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ), //This is the third column
              ],
            ),
          ),
        ],
      ),
    );
  }
}
