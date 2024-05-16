import 'package:flutter/material.dart';
import 'package:mad_quiz_app/provider/leaderboard_provider.dart';
import 'package:provider/provider.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LeaderboardProvider>(builder: (context, state, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (String category in state.categories)
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: FilterChip(
                      label: Text(category),
                      onSelected: (selected) {
                        if (selected) state.changeCategoryFilter(category);
                      },
                      selected: category == state.categoryFilter,
                    ),
                  )
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (String difficulty in state.difficulties)
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: FilterChip(
                      label: Text(difficulty),
                      onSelected: (selected) {
                        if (selected) state.changeDifficultyFilter(difficulty);
                      },
                      selected: difficulty == state.difficultyFilter,
                    ),
                  )
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          StreamBuilder(
              stream: state.firestore
                  .collection("scores")
                  .where("category", isEqualTo: state.categoryFilter)
                  .where("difficulty", isEqualTo: state.difficultyFilter)
                  .orderBy("score", descending: true)
                  .snapshots(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                final scores = snapshot.data?.docs;

                return (scores == null || scores.isEmpty)
                    ? const Center(child: Text("No scores yet."))
                    : Column(
                        children: [
                          const Text("Leaderboard",
                              style: TextStyle(fontSize: 20)),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: scores.length,
                              itemBuilder: (context, index) {
                                final score = scores[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: ListTile(
                                      title: Text(
                                          "User: ${score['email']  == null ? "" :  score["email"]} - Score: ${score['score']}"),
                                      subtitle: Text(
                                          "Category: ${score['category']} - Difficulty: ${score['difficulty']} - ${score['timestamp'].toDate()}"),
                                    ),
                                  ),
                                );
                              })
                        ],
                      );
              }))
        ],
      );
    });
  }
}
