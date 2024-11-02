
import 'package:easy_localization/easy_localization.dart';
import 'package:mobx/mobx.dart';
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
    return 'days.days_of_week_${date.weekday - 1}'.tr();
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
    tasks = [
      ...tasks,
      Task(title: title, taskDate: selectedDate)
    ];
    saveTasks();
  }

  @computed
  List<Task> get filteredTasks => tasks.where((task) =>
  task.taskDate?.year == selectedDate.year &&
      task.taskDate?.month == selectedDate.month &&
      task.taskDate?.day == selectedDate.day).toList();

  @action
  void removeTask(int index) {
    tasks.remove(filteredTasks[index]);
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


