import 'package:flutter/material.dart';
import 'package:Do.it/database.dart';
import 'package:Do.it/main_task.dart';

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final fColor = const Color(0xFF4285F4);
    final black = const Color(0xFF171717);
    final yellow = const Color(0xFFffbe0b);
    DatabaseHelper _dbhelper = DatabaseHelper();
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        children: [
          SizedBox(height: 24),
          Container(
            alignment: Alignment.topLeft,
            height: 30,
            child: Text(
              'all tasks',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Gotham',
                fontSize: 36,
                color: black,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text("Previous"),
                Expanded(
                  child: FutureBuilder(
                      initialData: [],
                      future: _dbhelper.getTasks(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              if (int.parse(snapshot.data[index].year) ==
                                      now.year &&
                                  int.parse(snapshot.data[index].month) ==
                                      now.month &&
                                  int.parse(snapshot.data[index].day) >
                                      now.day) {
                                return TaskWidget(
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
                                );
                              }
                            });
                      }),
                ),
                Text("Today"),
                Expanded(
                  child: FutureBuilder(
                      initialData: [],
                      future: _dbhelper.getTasks(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              if (int.parse(snapshot.data[index].year) ==
                                      now.year &&
                                  int.parse(snapshot.data[index].month) ==
                                      now.month &&
                                  int.parse(snapshot.data[index].day) ==
                                      now.day) {
                                return TaskWidget(
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
                                );
                              }
                            });
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
