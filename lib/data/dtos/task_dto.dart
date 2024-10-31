import 'package:json_annotation/json_annotation.dart';

part 'task_dto.g.dart';

@JsonSerializable()
class Task {
  String title;
  bool isCompleted;
  DateTime? taskDate;

  Task({
    required this.title,
     this.taskDate,
    this.isCompleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}