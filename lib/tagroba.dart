import 'package:flutter/material.dart';

void main() => runApp(const TaskListApp());

class TaskListApp extends StatelessWidget {
  const TaskListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  TaskListScreenState createState() => TaskListScreenState();
}

class TaskListScreenState extends State<TaskListScreen> {
  List<String> tasks = [];
  final TextEditingController _taskController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int editingIndex = -1;
  final FocusNode _taskFocusNode = FocusNode();

  void addTask() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        String task = _taskController.text;
        if (editingIndex == -1) {
          tasks.add(task);
        } else {
          tasks[editingIndex] = task;
          editingIndex = -1;
        }
        _taskController.clear();
      });
    }
  }

  void startEditing(int index) {
    setState(() {
      editingIndex = index;
      _taskController.text = tasks[index];
      Future.delayed(const Duration(milliseconds: 50), () {
        FocusScope.of(context).requestFocus(_taskFocusNode);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(tasks[index]),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => startEditing(index),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _taskController,
                  decoration: const InputDecoration(
                    hintText: 'Enter task',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a task.';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: addTask,
            child: Icon(editingIndex == -1 ? Icons.add : Icons.save),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    FocusScope.of(context).unfocus();
    super.dispose();
  }
}
