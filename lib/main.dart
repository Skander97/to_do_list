import 'package:flutter/material.dart';
import 'package:to_do_list/LoginPage.dart';
import 'package:to_do_list/TaskListPage.dart';
import 'task.dart';





void main() {
  runApp(MaterialApp(
    title: 'To-Do List',
    home: TaskListPage(tasks: tasks, isAuthenticated: true), 
    //home: LoginPage(), 

  ));
}