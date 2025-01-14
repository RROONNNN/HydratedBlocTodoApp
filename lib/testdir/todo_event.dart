import 'package:ronfltapp/testdir/todo_model.dart';

sealed class TodoEvent {}

final class TodoFetch extends TodoEvent {}

final class TodoAdd extends TodoEvent {
  final TodoModel task;
  TodoAdd(this.task);
}

final class TodoRemove extends TodoEvent {
  final int id;
  TodoRemove(this.id);
}

final class TodoUpdate extends TodoEvent {
  final int id;
  final bool status;
  TodoUpdate(this.id, this.status);
}