import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/AddTaskScreen.dart';
import 'package:to_do_list/InscriptionPage.dart';
import 'package:to_do_list/LoginPage.dart';
import 'package:to_do_list/task.dart';

void main() {
  group('Tests de la classe AddTaskScreen', () {
    testWidgets('Vérifie si AddTaskScreen s\'affiche correctement', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: AddTaskScreen()));
      expect(find.text('Ajouter une tâche'), findsOneWidget);
    });
  });

  group('Tests de la classe InscriptionPage', () {
    testWidgets('Vérifie si InscriptionPage s\'affiche correctement', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: InscriptionPage()));
      expect(find.text('S\'inscrire'), findsOneWidget);
    });
  });

  group('Tests de la classe LoginPage', () {
    testWidgets('Vérifie si LoginPage s\'affiche correctement', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));
      expect(find.text('Connexion'), findsOneWidget);
    });
  });

  group('Tests de la classe Task', () {
    test('Vérifie la création d\'une tâche avec des données valides', () {
      final task = Task(title: 'Acheter du lait', description: 'Aller au supermarché');
      expect(task.title, 'Acheter du lait');
      expect(task.description, 'Aller au supermarché');
    });

    test('Vérifie que le titre de la tâche est vide', () {
      final task = Task(title: '', description: 'Aller au supermarché');
      expect(task.title.isEmpty, true);
    });

    test('Vérifie que la description de la tâche est vide', () {
      final task = Task(title: 'Acheter du lait', description: '');
      expect(task.description.isEmpty, true);
    });
  });
}