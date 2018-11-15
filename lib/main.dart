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

class _MyHomePageState extends State<MyHomePage>  {
  List<Task> tasks = [];

  int currentPage = 0;




  Widget getPage() {
    if (currentPage == 0) {
      return new TodoListSection(
        tasks: tasks,
        onTaskChangedCallback: (index, task) {
          setState(() {
            tasks[index] = task;
          });
        },
        onAddTask: (task) {
          setState(() {
            tasks.add(
              Task(
                  false, task
              ),
            );
          });
        },
      );
    } else if (currentPage == 1) {
      return new StatSection(
        tasks: tasks,
        onClear: () {
          setState(() {
            tasks.clear();
          });
        },
      );
    }

    throw Exception("Page $currentPage not found");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Todo App"),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.info),
              onPressed: () {
                Navigator.of(context).pushNamed("info");
              })
        ],
      ),
      body: getPage(),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(icon: const Icon(Icons.list), title: const Text("ToDo")),
          new BottomNavigationBarItem(icon: const Icon(Icons.show_chart), title: const Text("Statistics")),
        ],
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
    );
  }

}

typedef OnTaskChangedCallback = void Function(int index, Task task);

class TodoListSection extends StatelessWidget {
  const TodoListSection({Key key, this.tasks, this.onTaskChangedCallback, this.onAddTask}) : super(key: key);

  final List<Task> tasks;

  final OnTaskChangedCallback onTaskChangedCallback;

  final ValueChanged<String> onAddTask;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: new ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return new TaskTile(
                task: tasks[index],
                onChanged: (newValue) => onTaskChangedCallback(index, new Task(newValue, tasks[index].text)),
              );
            },
            itemCount: tasks.length,
          ),
        ),
        TaskInput(
          onAddTask: onAddTask,
        ),
      ],
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({Key key, this.task, this.onChanged}) : super(key: key);

  final Task task;

  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Checkbox(value: task.done, onChanged: onChanged),
        new Text(task.text),
      ],
    );
  }
}

class StatSection extends StatelessWidget {
  final List<Task> tasks;

  final VoidCallback onClear;

  const StatSection({Key key, this.tasks, @required this.onClear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text("Of ${tasks.length} tasks, ${_getNumberOfDoneTasks()} ${_getNumberOfDoneTasks() == 1 ? "is" : "are"} done"),
          new SizedBox(
            height: 12.0,
          ),
          new RaisedButton(
            onPressed: onClear,
            child: new Text("Clear list"),
          )
        ],
      ),
    );
  }

  int _getNumberOfDoneTasks() {
    return tasks.where((task) => task.done).length;
  }
}

class TaskInput extends StatelessWidget {


  TaskInput({Key key, this.onAddTask}) : super(key: key);

  final ValueChanged<String> onAddTask;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(child: TextField(
              controller: textEditingController,
              decoration: InputDecoration.collapsed(hintText: "Enter a task"),
            )),
            FloatingActionButton(
              mini: true,
              onPressed: () {
                String text = textEditingController.text;
                textEditingController.text = "";
                onAddTask(text);
              },
              child: Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
