import 'package:flutter/cupertino.dart';

import 'models/tasks.dart';

void addATask(String taskName) {
  final newTask = Tasks(nameOfTask: taskName);
  listOfTasks.add(newTask);
}

void editATask(Tasks newTodo) {
  int? selectedItemIndex;
  listOfTasks[selectedItemIndex!] = newTodo;
  selectedItemIndex = null;
  taskController.clear();
}

TextEditingController taskController = TextEditingController();

bool editTodoItem = false;

final FocusNode taskFocusNode = FocusNode();
