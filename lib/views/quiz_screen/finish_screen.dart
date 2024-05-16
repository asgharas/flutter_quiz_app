import 'package:flutter/material.dart';

class FinishScreen extends StatefulWidget {
  final String difficulty;
  final String topic;
  final int score;
  const FinishScreen({super.key, required this.score, required this.topic, required this.difficulty});

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column( mainAxisSize: MainAxisSize.min,
          children: [
            Text("${widget.topic} Quiz", style: const TextStyle(fontSize: 20)),
            const Padding(
              padding: EdgeInsets.all(12),
            ),
            Text("Your Score: ${widget.score}/10"),
            const Padding(
              padding: EdgeInsets.all(12),
            ),
            Text("Difficulty: ${widget.difficulty}"),
            const Padding(
              padding: EdgeInsets.all(12),
            ),
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Text("Go Home"))
          ],
        ),
      ),
    );
  }
}
