import 'package:flutter/material.dart';
import 'package:mad_quiz_app/provider/quiz_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(builder: (context, state, child) {
      return Column(
        children: [
          const Text("Welcome to Quiz Land", style: TextStyle(fontSize: 24)),
        ]
      )
    });
  }
}
