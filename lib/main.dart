import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new TaskPage(),
    );
  }
}


class Task {
  Task(this.name, this.done);

  final String name;
  final bool done;
}

class TaskPage extends StatefulWidget {

  const TaskPage({Key key}) : super(key: key);

  @override
  TaskPageState createState() {
    return new TaskPageState();
  }
}


// TODO bottom navigation bar change between stats and todo list


// TODO carbon folien mit signaturen machen



// TODO takes a list of task, provides a callback
class TaskPageState extends State<TaskPage> {


  List<Task> tasks = [
    Task("Hi", false),
    Task("Hi", false),
    Task("Hi", false),
    Task("Hi", false),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Todo App'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return TaskWidget(
          task: tasks[index],
          onTap: (val) {
            setState(() {
              tasks[index] = Task(tasks[index].name, val);
            });
          },
        );
      }, itemCount: tasks.length,),
    );
  }
}

class CreateTaskWidget extends StatelessWidget {

  const CreateTaskWidget({Key key, this.onTaskAdded}) : super(key: key);

  final ValueChanged<String> onTaskAdded;


  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}


class TaskWidget extends StatelessWidget {

  const TaskWidget({Key key, this.task, this.onTap}) : super(key: key);

  final Task task;

  final ValueChanged<bool> onTap;


  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}


