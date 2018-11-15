import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Task {
  Task(this.done, this.text);

  final String text;
  final bool done;
}

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: new MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  List<Task> tasks = [];

  int currentPage = 0;


  @override
  Widget build(BuildContext context) {

  }


}

typedef OnTaskChangedCallback = void Function(int index, Task task);

class TodoListSection extends StatelessWidget {

  const TodoListSection({Key key, this.tasks, this.onTaskChangedCallback}) : super(key: key);

  final List<Task> tasks;

  final OnTaskChangedCallback onTaskChangedCallback;

  @override
  Widget build(BuildContext context) {

  }
}

class TaskTile extends StatelessWidget {

  const TaskTile({Key key, this.task, this.onChanged}) : super(key: key);

  final Task task;

  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {

  }
}

class StatSection extends StatelessWidget {
  final List<Task> tasks;

  final VoidCallback onClear;

  const StatSection({Key key, this.tasks, @required this.onClear}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  }


}

class TaskInput extends StatelessWidget {


  TaskInput({Key key, this.onAddTask}) : super(key: key);

  final ValueChanged<String> onAddTask;

  final TextEditingController textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {

  }
}


