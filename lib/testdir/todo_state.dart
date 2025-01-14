import 'package:ronfltapp/testdir/todo_model.dart';

sealed class TodoState {}

final class TodoInitial extends TodoState {

}

final class TodoStateLoaded extends TodoState {
  final List<TodoModel> task;
  TodoStateLoaded(this.task);
}