import 'package:flutter/material.dart';
import 'package:tractiv/database.dart';

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
            height: 80,
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
          SizedBox(height: 24),
          Expanded(
            child: FutureBuilder(
                initialData: [],
                future: _dbhelper.getTasks(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: snapshot.data.length + 1,
                      itemBuilder: (context, index) {
                        return AllViewWidget(
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
                      });
                }),
          )
        ],
      ),
    );
  }
}

class AllViewWidget extends StatefulWidget {
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

  AllViewWidget(
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
  _AllViewWidgetState createState() => _AllViewWidgetState();
}

class _AllViewWidgetState extends State<AllViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
