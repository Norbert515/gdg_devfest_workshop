

import 'package:flutter/material.dart';



class Task {

  Task({@required this.done, this.name, this.myCallback});


  final bool done;

  final String name;

  final VoidCallback myCallback;

  void bla() {
    myCallback();
  }


  void doSomething() => print("Hallo");

}

void main() {
  Task task = Task(
    name: "Hallo",
    done: false,
    myCallback: () {

    }
  );
}