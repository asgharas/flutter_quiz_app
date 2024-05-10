import 'package:flutter/material.dart';
import 'package:mad_quiz_app/models/category.dart';
import 'package:mad_quiz_app/models/question.dart';
import 'package:mad_quiz_app/models/tag.dart';
import 'package:mad_quiz_app/repo/quiz_repo.dart';

class QuizProvider extends ChangeNotifier {
  final _repo = QuizRepo();

  var _tags = <Tag>[];
  get tags => _tags;

  var _categories = <Category>[];
  get categories => _categories;

  var _questions = <Question>[];
  get questions => _questions;

  var _selectedAnswers = <String>[];
  get selectedAnswers => _selectedAnswers;

  void addSelectedAnswer(String answer) {
    _selectedAnswers.add(answer);
    notifyListeners();
  }

  void getTags() async {
    _tags = await _repo.getTags();
    notifyListeners();
  }

  void getCategories() async {
    _categories = await _repo.getCategories();
    notifyListeners();
  }

  void getQuestions() async {
    _questions = await _repo.getQuestions();
    notifyListeners();
  }
}