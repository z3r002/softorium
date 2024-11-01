import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:softoriim/data/dtos/task_dto.dart';

class TaskStorageHelper {
  Future<List<Task>> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      List<dynamic> jsonList = json.decode(tasksJson);
      return jsonList.map((json) => Task.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> saveTasks(List<Task> tasks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonList =
        tasks.map((task) => task.toJson()).toList();
    prefs.setString('tasks', json.encode(jsonList));
  }
}
