import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  DateTime startDate = DateTime.now().subtract(Duration(days: 5));
  @observable
  DateTime endDate = DateTime.now().add(Duration(days: 10));
  @observable
  DateTime selectedDate = DateTime.now();

}