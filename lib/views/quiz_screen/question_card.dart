import 'package:flutter/material.dart';
import 'package:mad_quiz_app/models/question.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final Function (bool) onAnswered;

  const QuestionCard({super.key, required this.question, required this.onAnswered});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  var answers = [];
  var questionAnswered = false;

  @override
  void initState() {
    super.initState();
    answers = widget.question.getNonNullAnswers();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Center(
      child: Column(children: [
        Text(widget.question.question),
        for (String ans in answers)
          InkWell(
            onTap: () {
              setState(() {
                questionAnswered = true;
              });
              widget.onAnswered(widget.question.isAnswerCorrect(ans));
            },
            child: Card(
              color: questionAnswered
                  ? (widget.question.isAnswerCorrect(ans)
                      ? Colors.lightGreen
                      : Colors.redAccent)
                  : Theme.of(context).colorScheme.surface,
              child: Center(
                child: Text(ans),
              ),
            ),
          )
      ]),
    ));
  }
}
