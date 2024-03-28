import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_list/InscriptionPage.dart';
import 'package:to_do_list/TaskListPage.dart';
import 'task.dart';


List<Task> tasks = [
  Task(title: 'Acheter du lait', description: 'Aller au supermarché'),
  Task(title: 'Faire du sport', description: 'Courir pendant 30 minutes'),
];
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Contrôleurs pour les champs de texte
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    // Fonction pour gérer la connexion
    void handleLogin() async {
      // Récupérer les informations saisies par l'utilisateur
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();

      // Vérifier si les champs ne sont pas vides
      if (username.isNotEmpty && password.isNotEmpty) {
        // Envoyer les informations d'identification au backend pour l'authentification
        var url = Uri.parse('http://localhost/login.php');
        var response = await http.post(url, body: {
          'username': username,
          'password': password,
        });

        // Analyser la réponse JSON du serveur
        var data = jsonDecode(response.body);
        if (data['success'] == true) {
          // Rediriger vers la page de la liste des tâches une fois connecté avec succès
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TaskListPage(tasks: tasks, isAuthenticated: true),
            ),
          );
        } else {
          // Afficher un message d'erreur si l'authentification échoue
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // Afficher un message d'erreur si les champs sont vides
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Veuillez remplir tous les champs.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
        backgroundColor: Colors.blue, 
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white], 
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Nom d\'utilisateur',
                  filled: true,
                  fillColor: Colors.white, 
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: handleLogin, // Appeler la fonction pour gérer la connexion
                child: Text('Se connecter'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, 
                  padding: EdgeInsets.symmetric(vertical: 15.0), 
                ),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InscriptionPage()),
                  );
                },
                child: Text('S\'inscrire'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, 
                  padding: EdgeInsets.symmetric(vertical: 15.0), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}