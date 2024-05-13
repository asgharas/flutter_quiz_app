import 'package:flutter/material.dart';
import 'package:mad_quiz_app/provider/quiz_provider.dart';
import 'package:mad_quiz_app/views/quiz_screen/quiz_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(builder: (context, state, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Choose Quiz Category", style: TextStyle(fontSize: 20)),
          Expanded(
            child: state.tags.length <= 0
                ? const Center(child: CircularProgressIndicator())
                : GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    primary: false,
                    padding: const EdgeInsets.all(8),
                    children: state.tags
                        .map<Widget>((tag) => Card(
                              color:
                                  Theme.of(context).primaryColor.withAlpha(200),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              QuizScreen(tag: tag.name)));
                                },
                                child: Center(
                                  child: Text(tag.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      )),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
          ),
        ],
      );
    });
  }
}
