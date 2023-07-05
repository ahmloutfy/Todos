import 'package:flutter/material.dart';

import '../constants.dart';
import 'custom_button.dart';

SizedBox buildTaskList(
  BuildContext context,
  listOfTasks,
  setState,
) {

  Size size = MediaQuery.of(context).size;

  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All ToDos',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: size.height - 340,
              child: ListView.builder(
                itemCount: listOfTasks.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        fillColor: const MaterialStatePropertyAll(
                          Color(0xFF5F56E8),
                        ),
                        value: listOfTasks[index].isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            listOfTasks[index].isChecked = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          listOfTasks[index].nameOfTask!,
                          style: TextStyle(
                            decoration: listOfTasks[index].isChecked
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                      CustomButton(
                        press: () {
                          setState(() {
                            FocusScope.of(context).requestFocus(taskFocusNode);
                            editATask(
                                taskController.text = listOfTasks[index].nameOfTask
                            );
                            FocusScope.of(context).unfocus();
                            taskController.clear();
                          });
                        },
                        color: const Color(0xFF5F56E8),
                        customIcon: const Icon(Icons.edit),
                        customMargin: const EdgeInsets.only(right: 10),
                      ),
                      CustomButton(
                        press: () {
                          setState(() {
                            listOfTasks.removeAt(index);
                          });
                        },
                        color: Colors.red,
                        customIcon: const Icon(Icons.delete),
                        customMargin: const EdgeInsets.only(right: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
