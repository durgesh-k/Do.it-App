import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models/task.dart';
import 'models/todo.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, day TEXT,month TEXT,year TEXT,weekday TEXT,hour TEXT,minute TEXT )");
        await db.execute(
            "CREATE TABLE todo(id INTEGER PRIMARY KEY, taskId INTEGER, title TEXT, isDone INTEGER)");

        return db;
      },
      version: 1,
    );
  }

  Future<int> insertTask(Task task) async {
    int taskId = 0;
    Database _db = await database();
    await _db
        .insert('tasks', task.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      taskId = value;
    });
    return taskId;
  }

  Future<void> updateTaskTitle(int id, String title) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET title = '$title' WHERE id = '$id'");
  }

  Future<void> updateday(int id, String day) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET day = '$day' WHERE id = '$id'");
  }

  Future<void> updatemonth(int id, String month) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET month = '$month' WHERE id = '$id'");
  }

  Future<void> updateyear(int id, String year) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET year = '$year' WHERE id = '$id'");
  }

  Future<void> updatehour(int id, String hour) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET hour = '$hour' WHERE id = '$id'");
  }

  Future<void> updateminute(int id, String minute) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET minute = '$minute' WHERE id = '$id'");
  }

  Future<void> updateweekday(int id, String weekday) async {
    Database _db = await database();
    await _db
        .rawUpdate("UPDATE tasks SET weekday = '$weekday' WHERE id = '$id'");
  }

  Future<void> insertTodo(Todo todo) async {
    Database _db = await database();
    await _db.insert('todo', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('tasks');
    return List.generate(taskMap.length, (index) {
      return Task(
          id: taskMap[index]['id'],
          title: taskMap[index]['title'],
          day: taskMap[index]['day'],
          month: taskMap[index]['month'],
          year: taskMap[index]['year'],
          weekday: taskMap[index]['weekday'],
          hour: taskMap[index]['hour'],
          minute: taskMap[index]['minute']);
    });
  }

  Future<int> get() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap1 = await _db.query('tasks');
    return Future.value(taskMap1.length);
  }

  Future<List<Task>> getTasks1() async {
    Database _db = await database();
    DateTime now = DateTime.now();
    List<Map<String, dynamic>> taskMap1 = await _db.query('tasks');
    return List.generate(taskMap1.length, (index) {
      if (int.parse(taskMap1[index]['year']) == now.year &&
          int.parse(taskMap1[index]['month']) == now.month &&
          int.parse(taskMap1[index]['day']) == now.day) {
        return Task(
            id: taskMap1[index]['id'],
            title: taskMap1[index]['title'],
            day: taskMap1[index]['day'],
            month: taskMap1[index]['month'],
            year: taskMap1[index]['year'],
            weekday: taskMap1[index]['weekday'],
            hour: taskMap1[index]['hour'],
            minute: taskMap1[index]['minute']);
      }
    });
  }

  Future<List<Todo>> getTodo(int taskId) async {
    Database _db = await database();
    List<Map<String, dynamic>> todoMap =
        await _db.rawQuery("SELECT * FROM todo WHERE taskId = $taskId");
    return List.generate(todoMap.length, (index) {
      return Todo(
          id: todoMap[index]['id'],
          title: todoMap[index]['title'],
          taskId: todoMap[index]['taskId'],
          isDone: todoMap[index]['isDone']);
    });
  }

  Future<void> updateTodoDone(int id, int isDone) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE todo SET isDone = '$isDone' WHERE id = '$id'");
  }

  Future<void> deleteTask(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM tasks WHERE id = '$id'");
    await _db.rawDelete("DELETE FROM todo WHERE taskId = '$id'");
  }
}
