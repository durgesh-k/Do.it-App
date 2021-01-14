import 'package:flutter/material.dart';
import 'package:tractiv/taskpage.dart';
import 'package:tractiv/all_tasks.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

enum BottomIcons { Home, Favorite }

class _HomePageState extends State<HomePage> {
  //final bgColor = const Color(0xFFFFFF);
  final bgColor = Colors.white;
  //final fColor = const Color(0x4285F4);
  final fColor = const Color(0x4285F4);
  var list = ["Home", "Favorite"];
  int currentIndex = 0;
  var pageController = PageController();
  BottomIcons bottomIcons = BottomIcons.Home;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: //Stack(children: <Widget>[
          PageView(
        children: [TaskPage(), AllTasks()],
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
            currentIndex == 1
                ? bottomIcons = BottomIcons.Favorite
                : bottomIcons = BottomIcons.Home;
          });
        },
        controller: pageController,
      ),
      /*Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 24, right: 24, bottom: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BottomBar(
                        onPressed: () {
                          setState(() {
                            currentIndex = 0;
                            pageController.animateToPage(currentIndex,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.slowMiddle);
                            bottomIcons = BottomIcons.Home;
                          });
                        },
                        bottomIcons:
                            bottomIcons == BottomIcons.Home ? true : false,
                        icons: Icons.ac_unit_sharp,
                        text: "Tasks"),
                    BottomBar(
                        onPressed: () {
                          setState(() {
                            currentIndex = 1;
                            pageController.animateToPage(currentIndex,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.slowMiddle);
                            bottomIcons = BottomIcons.Favorite;
                          });
                        },
                        bottomIcons: bottomIcons == BottomIcons.Favorite
                            ? true
                            : false,
                        icons: Icons.home,
                        text: "Profile"),
                  ]),
            ),
          ),*/
      bottomNavigationBar: BottomNavyBar(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          backgroundColor: bgColor,
          showElevation: false,
          containerHeight: 50,
          curve: Curves.easeInOut,
          selectedIndex: currentIndex,
          onItemSelected: (index) {
            setState(() {
              currentIndex = index;
              pageController.animateToPage(currentIndex,
                  duration: Duration(milliseconds: 100),
                  curve: Curves.slowMiddle);
            });
          },
          items: [
            BottomNavyBarItem(
                icon: Icon(
                  Icons.access_alarm,
                  size: 15.0,
                  color: fColor.withOpacity(1.0),
                ),
                activeColor: fColor.withOpacity(1),
                /*Icon(
              Icons.access_alarm,
              size: 20.0,
              color: bgColor,
            ),*/
                title: Text('Today',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Averta',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: fColor.withOpacity(1.0)))),
            BottomNavyBarItem(
                icon: Icon(
                  Icons.access_alarm,
                  size: 15.0,
                  color: fColor.withOpacity(1.0),
                ),
                activeColor: fColor.withOpacity(0.2),
                /*Icon(
              Icons.ac_unit_sharp,
              size: 20.0,
              color: bgColor,
            ),*/
                title: Text('All Tasks',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Averta',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: fColor.withOpacity(1.0)))),
          ]),
    );
  }
}
