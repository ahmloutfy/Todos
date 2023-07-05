import 'package:flutter/cupertino.dart';

import 'models/tasks.dart';

void addATask(Tasks taskName) {
  listOfTasks.add(taskName);
  taskController.clear();
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
