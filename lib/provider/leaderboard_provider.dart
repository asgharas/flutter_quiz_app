import 'package:flutter/material.dart';
import 'package:mad_quiz_app/repo/quiz_repo.dart';

class LeaderboardProvider with ChangeNotifier {
  var _repo = QuizRepo();

}