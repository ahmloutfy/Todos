import 'package:flutter/material.dart';

import 'constants.dart';

class Tasks {
  String? nameOfTask;
  bool isChecked;

  Tasks({this.nameOfTask, this.isChecked = false});
}

List<Tasks> listOfTasks = [
  Tasks(nameOfTask: 'Workflow'),
];

class TodosDemo extends StatefulWidget {
  const TodosDemo({Key? key}) : super(key: key);

  @override
  State<TodosDemo> createState() => _TodosDemoState();
}

class _TodosDemoState extends State<TodosDemo> {
  final TextEditingController _todoTextController = TextEditingController();
  final TextEditingController _editTodoTextController = TextEditingController();

  int _editingIndex = -1;

  @override
  void dispose() {
    _todoTextController.dispose();
    _editTodoTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void addTodo() {
      setState(() {
        String todoText = _todoTextController.text;
        if (todoText.isNotEmpty) {
          listOfTasks.add(Tasks(nameOfTask: todoText));
          _todoTextController.clear();
        }
      });
      FocusScope.of(context).unfocus();
    }

    void editTodo() {
      if (_editingIndex != -1) {
        setState(() {
          FocusScope.of(context).requestFocus(taskFocusNode);

          String editedTodoText = _editTodoTextController.text;
          if (editedTodoText.isNotEmpty) {
            listOfTasks[_editingIndex].nameOfTask = editedTodoText;
            _editingIndex = -1;
            _editTodoTextController.clear();
          }
        });
      }

      FocusScope.of(context).unfocus();
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: Row(
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
                    controller: _todoTextController,
                    decoration: InputDecoration(
                      hintText: 'Add a new todo item',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 17, horizontal: 20),
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
                if (_editingIndex != -1) {
                  editTodo();
                } else {
                  addTodo();
                }
              },
              shape: const BeveledRectangleBorder(),
              backgroundColor: const Color(0xFF5F56E8),
              child: Container(
                padding: const EdgeInsets.only(bottom: 3, right: 2),
                alignment: Alignment.center,
                child: (_editingIndex != -1)
                    ? const Icon(
                        Icons.check,
                        size: 40,
                      )
                    : const Icon(
                        Icons.add,
                        size: 40,
                      ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFEDEEF3),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                      ),
                      const Spacer(),
                      const CircleAvatar(
                        backgroundImage: AssetImage('images/apples.jpeg'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.search),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 35,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
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
                                      child: (_editingIndex == index)
                                          ? TextFormField(
                                              controller:
                                                  _editTodoTextController,
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                                border: InputBorder.none,
                                              ),
                                            )
                                          : Text(
                                              listOfTasks[index].nameOfTask!,
                                              style: TextStyle(
                                                decoration: listOfTasks[index]
                                                        .isChecked
                                                    ? TextDecoration.lineThrough
                                                    : null,
                                              ),
                                            ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF5F56E8),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      height: 35,
                                      width: 45,
                                      child: IconButton(
                                        padding:
                                            const EdgeInsets.only(bottom: 2),
                                        onPressed: () {
                                          setState(() {
                                            _editingIndex = index;
                                            _editTodoTextController.text =
                                                listOfTasks[index].nameOfTask!;
                                          });
                                        },
                                        icon: const Icon(Icons.edit),
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      height: 35,
                                      width: 45,
                                      child: IconButton(
                                        padding:
                                            const EdgeInsets.only(bottom: 2),
                                        onPressed: () {
                                          setState(() {
                                            listOfTasks.removeAt(index);
                                          });
                                        },
                                        icon: const Icon(Icons.delete),
                                        color: Colors.white,
                                      ),
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
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
