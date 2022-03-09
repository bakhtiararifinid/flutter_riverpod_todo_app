import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const Todo._();

  const factory Todo({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'description') String? title,
    @Default(false) bool completed,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJsonForm() {
    final json = toJson();
    json.remove('_id');

    return json;
  }
}
