import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ronfltapp/testdir/todo_event.dart';
import 'package:ronfltapp/testdir/todo_model.dart';
import 'package:ronfltapp/testdir/todo_repository.dart';
import 'package:ronfltapp/testdir/todo_state.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
  Future<void> fakeLoading() async {
    await Future.delayed(Duration(seconds: 1));
  }
  final TodoRepo todoRepo = TodoRepo();
  TodoBloc() : super(TodoInitial()) {
    on<TodoFetch>((event, emit) async {
      print("TodoFetch");
      emit(TodoStateLoaded(todoRepo.tasks));
    });
    on<TodoAdd>((event, emit) async {
      await fakeLoading();
      print("TodoAdd");
      emit(TodoStateLoaded(todoRepo.addTodo(event.task)));
    });
    on<TodoRemove>((event, emit) async {
      await fakeLoading();
      print("TodoRemove");
      emit(TodoStateLoaded(todoRepo.removeTodo(event.id)));
    });
    on<TodoUpdate>((event, emit) async {
      await fakeLoading();
      print("TodoUpdate");
      emit(TodoStateLoaded(todoRepo.updateTask(event.id, event.status)));
    });
  }
  @override
  TodoState? fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && (json['data'] as List<dynamic>).isNotEmpty) {
      return TodoStateLoaded((json['data'] as List<dynamic>)
          .map((e) => TodoModel.fromJson(e))
          .toList());
    }
    return TodoInitial();
  }

  @override
  Map<String, dynamic>? toJson(TodoState state) {
    if (state is TodoStateLoaded) {
      print("toJson, ");
      return {'data': state.task.map((e) => e.toJson()).toList()};
    }
    return {'data': []};
  }
}