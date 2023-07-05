import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/tasks.dart';
import 'empty_field_alert.dart';

class AddNewToDo extends StatefulWidget {
  const AddNewToDo({
    Key? key,
    required this.addTodo,
    this.initialTask,
    required this.editTodo,
  }) : super(key: key);

  final String? initialTask;
  final Function addTodo;
  final Function editTodo;

  @override
  State<AddNewToDo> createState() => _AddNewToDoState();
}

class _AddNewToDoState extends State<AddNewToDo> {

  Tasks? missions;

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialTask != null) {
      taskController.text = widget.initialTask!;
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 25),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 35,
                  offset: Offset(0, 5),
                  color: Colors.black38,
                ),
              ],
            ),
            child: SizedBox(
              width: size.width / 1.7,
              child: TextFormField(
                // autofocus: true,
                focusNode: taskFocusNode,
                controller: taskController,
                decoration: InputDecoration(
                  hintText: 'Add a new todo item',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        FloatingActionButton(
          onPressed: () {
            setState(() {
              if (missions!= null) {
                editATask(
                    Tasks(
                      nameOfTask: taskController.text,
                    )
                );

              } else if (missions == null) {

                addATask(
                    Tasks(
                      nameOfTask: taskController.text,
                    ),
                );
              }

                else {
                setState(() {
                  showAlertDialog(context);
                });
              }
            });
          },
          shape: const BeveledRectangleBorder(),
          backgroundColor: const Color(0xFF5F56E8),
          child: Container(
            padding: const EdgeInsets.only(bottom: 3, right: 2),
            alignment: Alignment.center,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}
