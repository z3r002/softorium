import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softoriim/presenter/home/store/home_store.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late HomeStore homeStore;
  late MockSharedPreferences mockPrefs;

  setUp(() {
   TestWidgetsFlutterBinding.ensureInitialized();

    mockPrefs = MockSharedPreferences();
    homeStore = HomeStore();
  });

  group('HomeStore', () {
    test('Initial dates are correct', () {
      expect(homeStore.startDate.isBefore(DateTime.now()), isTrue);
      expect(homeStore.endDate.isAfter(DateTime.now()), isTrue);
    });

    test('getDayOfWeek returns correct day', () {
      DateTime date = DateTime(2023, 11, 1); // Среда
      expect(homeStore.getDayOfWeek(date), 'Ср');
    });


    test('addTask adds a task', () async {
      homeStore.addTask('New Task');
      expect(homeStore.tasks.length, 1);
      expect(homeStore.tasks.first.title, 'New Task');
    });

    test('removeTask removes a task by index', () async {
      homeStore.addTask('Task to remove');
      homeStore.removeTask(0);
      expect(homeStore.tasks.isEmpty, isTrue);
    });

    test('toggleTaskCompletion toggles task status', () {
      homeStore.addTask('Task to complete');
      homeStore.toggleTaskCompletion(0);
      expect(homeStore.tasks[0].isCompleted, isTrue);
      homeStore.toggleTaskCompletion(0);
      expect(homeStore.tasks[0].isCompleted, isFalse);
    });

    test('loadTasks loads tasks from SharedPreferences', () async {
      // Заготовим JSON для теста
      List<Map<String, dynamic>> tasksJson = [
        {'title': 'Loaded Task', 'isCompleted': false}
      ];
      when(mockPrefs.getString('tasks')).thenReturn(json.encode(tasksJson));

      // Переопределите SharedPreferences для HomeStore
      SharedPreferences.setMockInitialValues({'tasks': json.encode(tasksJson)});
      await homeStore.loadTasks();

      expect(homeStore.tasks.length, 1);
      expect(homeStore.tasks[0].title, 'Loaded Task');
    });

  });
}