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
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "info": (BuildContext context) => new InfoPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{


  List<Task> tasks = [];

  int currentPage = 0;

  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(vsync: this, duration: const Duration(milliseconds: 700), value: 1.0);
  }


  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Widget getPage() {
    if(currentPage == 0) {
      return new TodoListSection(
        tasks: tasks,
        onTaskChangedCallback: (index, task) {
          setState(() {
            tasks[index] = task;
          });
        },
      );
    } else if (currentPage == 1){
      return new StatSection(
        tasks: tasks,
        onClear: (){
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
        title: new Text(widget.title),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.info), onPressed: (){
            Navigator.of(context).pushNamed("info");
          })
        ],
      ),
      body: getPage(),
      floatingActionButton: new FadeTransition(
        opacity: controller.view,
        child: new FloatingActionButton(
          onPressed: _onAdd,
          child: const Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              title: const Text("ToDo")
          ),
          new BottomNavigationBarItem(
              icon: const Icon(Icons.show_chart),
              title: const Text("Statistics")
          ),
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

  void _hideButton() {
    controller.reverse(from: 1.0);
  }

  void _showButton() {
    controller.forward(from: 0.0);
  }

  void _onAdd() async {
    _hideButton();
    String text = await showDialog<String>(context: context, builder: (BuildContext context) {
      TextEditingController controller = new TextEditingController();
      return new AlertDialog(
        content: new TextField(
          controller: controller,
          decoration: new InputDecoration(hintText: "Add a new task"),),
        actions: <Widget>[
          new MaterialButton(onPressed: () {
            controller.dispose();
            Navigator.of(context).pop(null);
          },
            child: new Text("Cancle"),
          ),
          new MaterialButton(onPressed: () {
            String text = controller.text;
            controller.dispose();
            Navigator.of(context).pop(text);
          },
            child: new Text("Save"),
          )
        ],
      );
    });

    if(text != null) {
      setState(() {
        tasks.add(new Task(false, text));
      });
    }
    _showButton();
  }
}

typedef OnTaskChangedCallback = void Function(int index, Task task);

class TodoListSection extends StatelessWidget {

  const TodoListSection({Key key, this.tasks, this.onTaskChangedCallback}) : super(key: key);

  final List<Task> tasks;

  final OnTaskChangedCallback onTaskChangedCallback;


  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return new TaskTile(task: tasks[index], onChanged: (newValue) => onTaskChangedCallback(index, new Task(newValue, tasks[index].text)),);
      }, itemCount: tasks.length,
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
          new Text("Of ${tasks.length} tasks, ${_getNumberOfDoneTasks()} ${_getNumberOfDoneTasks() == 1? "is": "are"} done"),
          new SizedBox(height: 12.0,),
          new RaisedButton(onPressed: onClear, child: new Text("Clear list"),)
        ],
      ),
    );
  }


  int _getNumberOfDoneTasks() {
    return tasks.where((task)=> task.done).length;
  }
}

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Info Page"),),
      body: new Center(
        child: new Text("This app is programmed at the PG"),
      ),
    );
  }
}