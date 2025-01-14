import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ronfltapp/core/configs/theme/app_theme.dart';
import 'package:ronfltapp/presentation/choose_mode/pages/choose_mode.dart';
import 'package:ronfltapp/presentation/intro/pages/get_started.dart';
import 'package:ronfltapp/presentation/splash/pages/splash.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ronfltapp/testdir/test_hydreated_bloc.dart';
import 'package:ronfltapp/testdir/todo_event.dart';
import 'package:ronfltapp/testdir/todo_model.dart';
import 'package:ronfltapp/testdir/todo_state.dart';
// void main() {
//
//   runApp(const MyApp());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) { return TodoBloc(); },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TODO Demo',
        theme: AppTheme.darkTheme,
        home: TodoScreen() ,
      ),
    );
  }
}
class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}
class TodoAddScreen extends StatefulWidget {
  const TodoAddScreen({super.key});

  @override
  State<TodoAddScreen> createState() => _TodoAddScreenState();
}

class _TodoAddScreenState extends State<TodoAddScreen> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final TextEditingController titleText = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Add Task",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: titleText,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Title required";
                  }
                  if (value.length < 3) {
                    return "Should have minimum 3 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Title",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.blue)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.black)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: description,
                maxLength: 100,
                maxLines: null,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "description required";
                  }
                  if (value.length < 10) {
                    return "Required description minimum length is 10 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Description",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.blue)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.black)),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.red,
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<TodoBloc>(context)
                            .add(TodoAdd(TodoModel.fromJson({
                          'id': DateTime.now().millisecondsSinceEpoch +
                              Random().nextInt(9999999),
                          'title': titleText.text,
                          'description': description.text,
                          'is_completed': false,
                          'created_at': DateTime.now().toUtc().toIso8601String(),
                          'updated_at': DateTime.now().toUtc().toIso8601String()
                        })));
                        Navigator.pop(context);
                      }
                    },
                    color: Colors.green,
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}


class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(context: context, builder: (context)=>const AlertDialog(
          content: TodoAddScreen(),
        ));
      }),
      body: BlocBuilder<TodoBloc,TodoState>(builder: (context,state){

        if (state is TodoStateLoaded){
          return state.task.isEmpty ? const EmptyListWidget()
              : TaskViewBuilder(tasks: state.task);

        }
        return const EmptyListWidget();

      }),
    );
  }
}
class TaskViewBuilder extends StatelessWidget {
  final List<TodoModel> tasks;
  const TaskViewBuilder({super.key, required this.tasks});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          TodoModel task = tasks[index];
          String time =task.updatedAt;

          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                            task.title,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<TodoBloc>(context)
                                .add(TodoRemove(task.id));
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 35,
                            color: Colors.red,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: Text(
                            task.description,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade300),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        time,
                        style:
                        const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                  splashRadius: 30,
                                  shape: const CircleBorder(
                                      side: BorderSide(color: Colors.white)),
                                  value: task.isCompleted,
                                  activeColor: Colors.green,
                                  onChanged: (value) {
                                    BlocProvider.of<TodoBloc>(context)
                                        .add(TodoUpdate(task.id, value!));
                                  }),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            task.isCompleted ? "Completed" : "Incomplete",
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ));
        });
  }
}

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No task has bene added"),
    );
  }
}


