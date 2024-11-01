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
  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      List<dynamic> jsonList = json.decode(tasksJson);
      tasks = jsonList.map((json) => Task.fromJson(json)).toList();
    }
  }

  @action
  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonList = tasks.map((task) => task.toJson()).toList();
    prefs.setString('tasks', json.encode(jsonList));
  }

  @action
  void addTask(String title) {
    tasks.add(Task(title: title, taskDate: selectedDate));
    tasks = [...tasks];
    saveTasks();
  }

  @computed
  List<Task> get filteredTasks => tasks.where((task) =>
  task.taskDate?.year == selectedDate.year &&
      task.taskDate?.month == selectedDate.month &&
      task.taskDate?.day == selectedDate.day
  ).toList();

  @action
  void removeTask(int index) {
    // Удаляем задачу из отфильтрованного списка для текущей даты
    final taskToRemove = filteredTasks[index];
    tasks.removeWhere((task) => task == taskToRemove);
    saveTasks();
    tasks = [...tasks];
  }
  @action
  void toggleTaskCompletion(int index) {
    // Меняем статус выполнения задачи в отфильтрованном списке для текущей даты
    final taskToToggle = filteredTasks[index];
    taskToToggle.isCompleted = !taskToToggle.isCompleted;
    tasks = [...tasks];
    saveTasks();
  }

  @action
  void selectDate(DateTime date) {
    selectedDate = date;
    tasks = [...tasks]; // Обновляем список, чтобы отобразить задачи для выбранной даты
  }
}
