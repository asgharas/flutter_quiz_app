import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mad_quiz_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAuthProvider>(builder: (context, state, child) {
      return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text("Email: ${state.currentUser.email}",
                  style: const TextStyle(fontSize: 20)),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("scores")
                      .where("userId", isEqualTo: state.currentUser.uid)
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
                              const Text("Scores",
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
                                              "Category: ${score['category']} - Score: ${score['score']}"),
                                          subtitle: Text(
                                              "Difficulty: ${score['difficulty']} - ${score['timestamp'].toDate()}"),
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          );
                  }))
            ],
          ));
    });
  }
}
