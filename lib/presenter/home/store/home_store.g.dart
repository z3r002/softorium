// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  Computed<List<Task>>? _$filteredTasksComputed;

  @override
  List<Task> get filteredTasks => (_$filteredTasksComputed ??=
          Computed<List<Task>>(() => super.filteredTasks,
              name: '_HomeStore.filteredTasks'))
      .value;

  late final _$startDateAtom =
      Atom(name: '_HomeStore.startDate', context: context);

  @override
  DateTime get startDate {
    _$startDateAtom.reportRead();
    return super.startDate;
  }

  @override
  set startDate(DateTime value) {
    _$startDateAtom.reportWrite(value, super.startDate, () {
      super.startDate = value;
    });
  }

  late final _$endDateAtom = Atom(name: '_HomeStore.endDate', context: context);

  @override
  DateTime get endDate {
    _$endDateAtom.reportRead();
    return super.endDate;
  }

  @override
  set endDate(DateTime value) {
    _$endDateAtom.reportWrite(value, super.endDate, () {
      super.endDate = value;
    });
  }

  late final _$selectedDateAtom =
      Atom(name: '_HomeStore.selectedDate', context: context);

  @override
  DateTime get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  late final _$tasksAtom = Atom(name: '_HomeStore.tasks', context: context);

  @override
  List<Task> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(List<Task> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$selectedTaskIndexAtom =
      Atom(name: '_HomeStore.selectedTaskIndex', context: context);

  @override
  int? get selectedTaskIndex {
    _$selectedTaskIndexAtom.reportRead();
    return super.selectedTaskIndex;
  }

  @override
  set selectedTaskIndex(int? value) {
    _$selectedTaskIndexAtom.reportWrite(value, super.selectedTaskIndex, () {
      super.selectedTaskIndex = value;
    });
  }

  late final _$loadTasksAsyncAction =
      AsyncAction('_HomeStore.loadTasks', context: context);

  @override
  Future<void> loadTasks() {
    return _$loadTasksAsyncAction.run(() => super.loadTasks());
  }

  late final _$saveTasksAsyncAction =
      AsyncAction('_HomeStore.saveTasks', context: context);

  @override
  Future<void> saveTasks() {
    return _$saveTasksAsyncAction.run(() => super.saveTasks());
  }

  late final _$_HomeStoreActionController =
      ActionController(name: '_HomeStore', context: context);

  @override
  String getDayOfWeek(DateTime date) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.getDayOfWeek');
    try {
      return super.getDayOfWeek(date);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTask(String title) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.addTask');
    try {
      return super.addTask(title);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTask(int index) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.removeTask');
    try {
      return super.removeTask(index);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleTaskCompletion(int index) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.toggleTaskCompletion');
    try {
      return super.toggleTaskCompletion(index);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectDate(DateTime date) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.selectDate');
    try {
      return super.selectDate(date);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
startDate: ${startDate},
endDate: ${endDate},
selectedDate: ${selectedDate},
tasks: ${tasks},
selectedTaskIndex: ${selectedTaskIndex},
filteredTasks: ${filteredTasks}
    ''';
  }
}
