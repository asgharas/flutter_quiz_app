import 'package:flutter/material.dart';
import 'package:mad_quiz_app/models/question.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final bool isLastQuestion;
  final Function(bool) onAnswered;
  final Function(bool) onFinish;

  const QuestionCard(
      {super.key,
      required this.question,
      required this.onAnswered,
      required this.isLastQuestion,
      required this.onFinish});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  var answers = [];
  var questionAnswered = false;
  var isCorrect = false;

  @override
  void initState() {
    super.initState();
    answers = widget.question.getNonNullAnswers();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.question.question,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(widget.question.description)
                ],
              ),
            ),
            for (String ans in answers)
              ans != ""
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          questionAnswered = true;
                          isCorrect = widget.question.isAnswerCorrect(ans);
                        });
                      },
                      child: Card(
                        shape: questionAnswered
                            ? RoundedRectangleBorder(
                                side: BorderSide(
                                    color: (widget.question.isAnswerCorrect(ans)
                                        ? Colors.lightGreen
                                        : Colors.redAccent),
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(8.0))
                            : RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Theme.of(context).colorScheme.surface,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(ans),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            if (questionAnswered)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  isCorrect ? Icons.check : Icons.close,
                  size: 48,
                  color: isCorrect ? Colors.lightGreen : Colors.redAccent,
                ),
              ),
            if (questionAnswered)
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(widget.question.explanation),
              ),
            if (questionAnswered)
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    widget.isLastQuestion
                        ? widget.onFinish(isCorrect)
                        : widget.onAnswered(isCorrect);
                  },
                  child: Text(widget.isLastQuestion ? "Finish" : "Next"),
                ),
              )
          ]),
        ));
  }
}
