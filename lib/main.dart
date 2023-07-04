import 'package:flutter/material.dart';
import 'package:todos/widgets/add_new_todo.dart';
import 'package:todos/widgets/custom_bar.dart';
import 'package:todos/widgets/search_bar_widget.dart';
import 'package:todos/widgets/task_list.dart';
import 'constants.dart';
import 'models/tasks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodosHome(),
    );
  }
}

class TodosHome extends StatefulWidget {
  final String? task;

  const TodosHome({Key? key, this.task}) : super(key: key);

  @override
  State<TodosHome> createState() => _TodosHomeState();
}

class _TodosHomeState extends State<TodosHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: const AddNewToDo(
          addTodo: addATask,
          editTodo: editATask,
        ),
        backgroundColor: const Color(0xFFEDEEF3),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomBar(),
                const SearchBarWidget(),
                const SizedBox(
                  height: 8,
                ),
                buildTaskList(context, listOfTasks, setState ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}