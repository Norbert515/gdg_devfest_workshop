import 'package:flutter/material.dart';
import 'package:pimp_my_button/pimp_my_button.dart';

class Task {

  Task({this.done, this.name});

  final bool done;

  final String name;
}

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
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

class _MyHomePageState extends State<MyHomePage> {

  VoidCallback myCallback;


  List<Task> tasks = [
    Task(
      done: false,
      name: "Hi",
    ),
    Task(
      done: true,
      name: "Some name",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: TodoListSection(
        tasks: tasks,
        onTaskChangedCallback: (index, task) {
          setState(() {
            tasks[index] = task;
          });
          print("The task: ${task.name} at index: $index changed to ${task.done}");
        },
        onAddTask: (text) {
          setState(() {
            tasks.add(
              Task(name: text,
                done: false,
              ),
            );
          });
        },
      ),
    );
  }
}



typedef OnTaskChangedCallback = void Function(int index, Task task);

class TodoListSection extends StatelessWidget {

  const TodoListSection({Key key, this.tasks, this.onAddTask, this.onTaskChangedCallback}) : super(key: key);

  final List<Task> tasks;

  final OnTaskChangedCallback onTaskChangedCallback;

  final ValueChanged<String> onAddTask;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(itemBuilder: (context, index) {
            return TaskTile(
              task: tasks[index],
              onChange: (newValue) {
                onTaskChangedCallback(index, Task(
                  done: newValue,
                  name: tasks[index].name,
                ));
              },
            );
          }, itemCount: tasks.length,),
        ),
        TaskInput(
          onAddTask: onAddTask,
        ),
      ],
    );
  }
}

class TaskInput extends StatelessWidget {


  TaskInput({Key key, this.onAddTask}) : super(key: key);

  final ValueChanged<String> onAddTask;

  final TextEditingController textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: textEditingController,
              ),
            ),
            IconButton(
              onPressed: () {
                String text = textEditingController.text;
                onAddTask(text);
                textEditingController.text = "";
              },
              icon: Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {

  const TaskTile({Key key, @required this.task, this.onChange}) : super(key: key);

  final Task task;

  final ValueChanged<bool> onChange;

  @override
  Widget build(BuildContext context) {
    return PimpedButton(
      particle: DemoParticle(),
      duration: Duration(milliseconds: 1000),
      pimpedWidgetBuilder: (context, controller) {
        return Row(
          children: <Widget>[
            Checkbox(value: task.done, onChanged: (it) {
              controller.forward(from: 0.0);
              onChange(it);
            }),
            Text(task.name,
              style: task.done?
              TextStyle(decoration: TextDecoration.lineThrough): null,)
          ],
        );
      },
    );
  }
}

