import 'package:intl/intl.dart';

List hours = [
  "01",
  "02",
  "03",
  "04",
  "05",
  "06",
  "07",
  "08",
  "09",
  "10",
  "11",
  "12",
];
List mins = [
  "00",
  "01",
  "02",
  "03",
  "04",
  "05",
  "06",
  "07",
  "08",
  "09",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23",
  "24",
  "25",
  "26",
  "27",
  "28",
  "29",
  "30",
  "31",
  "32",
  "33",
  "34",
  "35",
  "36",
  "37",
  "38",
  "39",
  "40",
  "41",
  "42",
  "43",
  "44",
  "45",
  "46",
  "47",
  "48",
  "49",
  "50",
  "51",
  "52",
  "53",
  "54",
  "55",
  "56",
  "57",
  "58",
  "59",
];
List type = ["AM", "PM"];

class DateHelper {
  String getmonth(String data) {
    if (data == "01") {
      return "January";
    } else if (data == "02") {
      return "February";
    } else if (data == "03") {
      return "March";
    } else if (data == "04") {
      return "April";
    } else if (data == "05") {
      return "May";
    } else if (data == "06") {
      return "June";
    } else if (data == "07") {
      return "July";
    } else if (data == "08") {
      return "August";
    } else if (data == "09") {
      return "September";
    } else if (data == "10") {
      return "October";
    } else if (data == "11") {
      return "November";
    } else if (data == "12") {
      return "December";
    }
  }

  String getWeek(DateTime datetime) {
    String weekday = DateFormat('EEEE').format(datetime);
    return '$weekday';
  }
}
