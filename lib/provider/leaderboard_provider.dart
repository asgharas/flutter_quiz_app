import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mad_quiz_app/repo/quiz_repo.dart';

class LeaderboardProvider with ChangeNotifier {
  var _repo = QuizRepo();
  var firestore = FirebaseFirestore.instance;

  var _categoryFilter = "uncategorized";
  get categoryFilter => _categoryFilter;

  var _difficultyFilter = "easy";
  get difficultyFilter => _difficultyFilter;

  final _categories = <String>[];
  get categories => _categories;

  final _difficulties = ["easy", "medium", "hard"];
  get difficulties => _difficulties;

  LeaderboardProvider() {
    _getCategories();
  }

  void _getCategories() async {
    _categories.clear();
    var categories = await _repo.getCategories();
    _categories.addAll(categories.map((e) => e.name).toList());
    notifyListeners();
  }

  void changeCategoryFilter(String category) {
    _categoryFilter = category;
    notifyListeners();
  }

  void changeDifficultyFilter(String difficulty) {
    _difficultyFilter = difficulty;
    notifyListeners();
  }
}