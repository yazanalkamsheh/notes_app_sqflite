import 'package:flutter/material.dart';
import 'package:flutter_notes_app_sqflite/add_notes.dart';
import 'package:flutter_notes_app_sqflite/edit_notes.dart';
import 'package:flutter_notes_app_sqflite/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color:Colors.deepPurple,foregroundColor: Colors.white),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      home: Home(),
      routes: {
        'addnotes' : (context) => AddNotes(),
        'editnotes' : (context) => EditNotes(),
      },
    );
  }
}