import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softoriim/data/dtos/task_dto.dart';
import 'package:softoriim/shared/consts/global.dart';
import 'package:softoriim/shared/widgets/castom_alert.dart';

class TaskStorageHelper {
  final SharedPreferences _prefs;

  TaskStorageHelper(this._prefs);

  Future<List<Task>> loadTasks() async {
    try {
      String? tasksJson = _prefs.getString('tasks');
      if (tasksJson != null) {
        List<dynamic> jsonList = json.decode(tasksJson) as List;
        return jsonList.map((json) => Task.fromJson(json as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e, stackTrace) {
      debugPrint('Error loading tasks: $e');
      debugPrintStack(stackTrace: stackTrace);
      _showErrorDialog();
      return [];
    }
  }

  Future<void> saveTasks(List<Task> tasks) async {
    try {
      List<Map<String, dynamic>> jsonList = tasks.map((task) => task.toJson()).toList();
      await _prefs.setString('tasks', json.encode(jsonList));
    } catch (e, stackTrace) {
      debugPrint('Error saving tasks: $e');
      debugPrintStack(stackTrace: stackTrace);
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: appRouter.navigatorKey.currentState!.context,
      builder: (_) => const UICustomAlert(),
    );
  }
}
