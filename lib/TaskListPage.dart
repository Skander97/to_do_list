import 'package:flutter/material.dart';
import 'package:to_do_list/AddTaskScreen.dart';
import 'task.dart';
import 'LoginPage.dart'; // Importer la page de connexion pour la redirection en cas de déconnexion

class TaskListPage extends StatefulWidget {
  final List<Task> tasks;
  final bool isAuthenticated; // Ajouter un booléen pour vérifier l'état de connexion

  TaskListPage({required this.tasks, required this.isAuthenticated});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  void _addTask(Task newTask) {
    setState(() {
      widget.tasks.add(newTask);
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      widget.tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Vérifier l'état de connexion
    if (!widget.isAuthenticated) {
      // Si l'utilisateur n'est pas connecté, rediriger vers la page de connexion
      return LoginPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des tâches'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.tasks.length,
              itemBuilder: (context, index) {
                final task = widget.tasks[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: task.completed ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text(task.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: task.completed,
                          onChanged: (value) {
                            setState(() {
                              task.completed = value ?? false;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteTask(task);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Naviguer vers l'écran d'ajout de tâches
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
          if (newTask != null) {
            _addTask(newTask); // Ajouter la nouvelle tâche à la liste de tâches
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}