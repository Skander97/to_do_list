import 'package:flutter/material.dart';
import 'task.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une tâche'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Titre de la tâche',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description de la tâche',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
  onPressed: () {
    String title = titleController.text;
    String description = descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      Task newTask = Task(title: title, description: description);
      Navigator.pop(context, newTask); // Passer la nouvelle tâche à TaskListPage
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez remplir tous les champs.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  },
  child: Text('Enregistrer'),
),
          ],
        ),
      ),
    );
  }
}
