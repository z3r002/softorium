import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softoriim/data/dtos/task_dto.dart';
import 'package:softoriim/utils/task_storage_helper.dart';

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

  final TaskStorageHelper storageHelper;


  _HomeStore(this.storageHelper) {
    loadTasks();
  }

  @action
  String getDayOfWeek(DateTime date) {
    List<String> days = [
      'days.days_of_week_0'.tr(),
      'days.days_of_week_1'.tr(),
      'days.days_of_week_2'.tr(),
      'days.days_of_week_3'.tr(),
      'days.days_of_week_4'.tr(),
      'days.days_of_week_5'.tr(),
      'days.days_of_week_6'.tr(),
    ];
    return days[date.weekday - 1];
  }

  @action
  Future<void> loadTasks() async {
    tasks = await storageHelper.loadTasks();
  }

  @action
  Future<void> saveTasks() async {
    await storageHelper.saveTasks(tasks);
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
    final taskToRemove = filteredTasks[index];
    tasks.remove(taskToRemove);
    tasks = [...tasks];
    saveTasks();
  }

  @action
  void toggleTaskCompletion(int index) {
    final taskToToggle = filteredTasks[index];
    taskToToggle.isCompleted = !taskToToggle.isCompleted;
    tasks = [...tasks];
    saveTasks();
  }

  @action
  void selectDate(DateTime date) {
    selectedDate = date;
  }
}

