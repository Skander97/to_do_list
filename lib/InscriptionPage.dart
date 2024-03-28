import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InscriptionPage extends StatelessWidget {
  // Définir une clé globale pour le Scaffold
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleInscription() async {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      // Effectuer la requête HTTP d'inscription vers le backend
      var url = Uri.parse('http://localhost/register.php');
      var response = await http.post(url, body: {
        'username': username,
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        // Afficher le message de succès avec un SnackBar
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
          SnackBar(
            content: Text('Inscription réussie.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Afficher le message d'erreur avec un SnackBar
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de l\'inscription.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Afficher un message d'erreur si les champs ne sont pas remplis
      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text('Veuillez remplir tous les champs.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // Utiliser la clé définie
      appBar: AppBar(
        title: Text('Inscription'),
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
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Adresse e-mail',
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
                onPressed: handleInscription,
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