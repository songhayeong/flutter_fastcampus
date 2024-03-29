import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart'; // build runner가 동작할 때 실행


@JsonSerializable()
@HiveType(typeId: 0)
class ToDo extends HiveObject {
  @HiveField(0)
  @JsonKey(name: '_id')
  String id;

  @HiveField(1)
  String text;

  @HiveField(2)
  bool done;

  ToDo({
    required this.id,
    required this.text,
    this.done = false,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) => _$ToDoFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoToJson(this);
}
