import 'package:flutter/material.dart';
import 'package:mad_quiz_app/provider/quiz_provider.dart';
import 'package:mad_quiz_app/views/quiz_screen/finish_screen.dart';
import 'package:mad_quiz_app/views/quiz_screen/question_card.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  final String tag;

  const QuizScreen({super.key, required this.tag});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var selectedDifficultyIndex = 0;
  var difficulties = ["easy", "medium", "hard"];
  var backLocked = false;
  var currentQuestionString = "";

  Future<bool> _onWillPop(BuildContext context) async {
    var res = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit the ongoing quiz?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return res ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !backLocked,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        if (await _onWillPop(context)) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Quiz"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Q# $currentQuestionString",
                style: const TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
        body: Consumer<QuizProvider>(builder: (context, state, child) {
          return PageView(
              physics: const NeverScrollableScrollPhysics(),
              pageSnapping: true,
              controller: state.pageController,
              scrollDirection: Axis.horizontal,
              children: [
                Stack(
                  children: [
                    Card(
                      child: Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Text("Choose Difficulty",
                                    style: TextStyle(fontSize: 20)),
                              ),
                              ToggleButtons(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  selectedColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fillColor: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  isSelected: List.generate(
                                      difficulties.length,
                                      (index) =>
                                          index == selectedDifficultyIndex),
                                  onPressed: (index) {
                                    setState(() {
                                      selectedDifficultyIndex = index;
                                    });
                                  },
                                  children: difficulties
                                      .map((difficulty) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(difficulty),
                                          ))
                                      .toList()),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      backLocked = true;
                                    });
                                    state
                                        .startQuiz(
                                            category: widget.tag,
                                            difficulty: difficulties[
                                                selectedDifficultyIndex],
                                            showSnackbar: (msg) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Quiz started.")));
                                            })
                                        .then((value) {
                                      setState(() {
                                        currentQuestionString = value;
                                      });
                                    });
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Start Quiz"),
                                      Icon(Icons.arrow_forward),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ),
                    state.quizLoading
                        ? Container(
                            color: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.9),
                            child: const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(),
                                  Text("Quiz loading, please wait a moment.")
                                ],
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
                for (var question in state.questions)
                  QuestionCard(
                    question: question,
                    onAnswered: (isCorrect) {
                      state.nextQuestion(isCorrect);
                      setState(() {
                        currentQuestionString =
                            "${state.pageController.page.toInt() + 1}/${state.questions.length}";
                      });
                    },
                    isLastQuestion: state.questions.indexOf(question) ==
                        state.questions.length - 1,
                    onFinish: (isCorrect) async {
                      await state.nextQuestion(isCorrect);
                      state.finishQuiz();
                      setState(() {
                        currentQuestionString = "";
                      });
                    },
                  ),
                FinishScreen(
                    score: state.score,
                    topic: state.currentTopic,
                    difficulty: state.currentDifficulty)
              ]);
        }),
      ),
    );
  }
}
