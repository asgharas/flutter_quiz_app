import 'package:flutter/material.dart';
import 'package:mad_quiz_app/provider/quiz_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => QuizProvider(),
        child: Scaffold(
          body: ,
        ),
      ),
    );
  }
}
