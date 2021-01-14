class Task {
  final int id;
  final String title;
  final String day;
  final String month;
  final String year;
  final String weekday;
  final String hour;
  final String minute;
  Task(
      {this.id,
      this.title,
      this.day,
      this.month,
      this.year,
      this.weekday,
      this.hour,
      this.minute});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'day': day,
      'month': month,
      'year': year,
      'weekday': weekday,
      'hour': hour,
      'minute': minute
    };
  }
}
