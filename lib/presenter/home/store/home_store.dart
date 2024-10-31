import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softoriim/data/dtos/task_dto.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  DateTime startDate = DateTime.now().subtract(Duration(days: 5));
  @observable
  DateTime endDate = DateTime.now().add(Duration(days: 10));
  @observable
  DateTime selectedDate = DateTime.now();
  @observable
  List<Task> tasks = [];
  @observable
  int? selectedTaskIndex;

  @action
  String getDayOfWeek(DateTime date) {
    const days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    return days[date.weekday - 1];
  }

  @action
  // Загрузка списка задач
  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      List<dynamic> jsonList = json.decode(tasksJson);
      tasks = jsonList.map((json) => Task.fromJson(json)).toList();
    }
  }

  @action
  // Сохранение списка задач
  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonList =
        tasks.map((task) => task.toJson()).toList();
    prefs.setString('tasks', json.encode(jsonList));
  }

  @action
  // Добавление задачи
  void addTask(String title) {
    tasks.add(Task(title: title, taskDate: selectedDate));
    tasks = [...tasks];

    saveTasks();
  }

// Обновление списка задач по выбранной дате
  List<Task> get filteredTasks => tasks.where((task) =>
  task.taskDate?.year == selectedDate.year &&
      task.taskDate?.month == selectedDate.month &&
      task.taskDate?.day == selectedDate.day
  ).toList();

  @action
  // Удаление задачи
  void removeTask(int index) {
    tasks.removeAt(index);
    saveTasks();
    tasks = [...tasks];

  }

  @action
  // Отметка задачи как выполненной
  void toggleTaskCompletion(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    tasks = [...tasks];
    saveTasks();
  }
}
