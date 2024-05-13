import 'package:flutter/material.dart';
import 'package:mad_quiz_app/models/category.dart';
import 'package:mad_quiz_app/models/question.dart';
import 'package:mad_quiz_app/models/tag.dart';
import 'package:mad_quiz_app/repo/quiz_repo.dart';

class QuizProvider extends ChangeNotifier {
  final _repo = QuizRepo();


  final _pageController = PageController();
  get pageController => _pageController;

  var _tags = <Tag>[];
  get tags => _tags;

  var _categories = <Category>[];
  get categories => _categories;

  var _questions = <Question>[];
  get questions => _questions;

  var _allAnswers = <bool>[];

  var _selectedQuestionIndex = 0;
  get selectedQuestionIndex => _selectedQuestionIndex;

  QuizProvider() {
    _getTags();
    _getCategories();
  }

  void addSelectedAnswer(bool answer) {
    _allAnswers.add(answer);
    notifyListeners();
  }

  void _getTags() async {
    _tags = await _repo.getTags();
    notifyListeners();
  }

  void _getCategories() async {
    _categories = await _repo.getCategories();
    notifyListeners();
  }

  Future<void> _getQuestions(String category, String difficulty) async {
    _questions = await _repo.getQuestions(category, difficulty);
    notifyListeners();
  }

  Future<void> startQuiz(String category, String difficulty) async {
    _allAnswers = [];
    await _getQuestions(category, difficulty);
    notifyListeners();
    _pageController.jumpToPage(1);
  }
}