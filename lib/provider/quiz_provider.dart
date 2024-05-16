import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_quiz_app/models/category.dart';
import 'package:mad_quiz_app/models/question.dart';
import 'package:mad_quiz_app/models/tag.dart';
import 'package:mad_quiz_app/repo/quiz_repo.dart';

class QuizProvider extends ChangeNotifier {
  final _repo = QuizRepo();
  final _auth = FirebaseAuth.instance;

  final _pageController = PageController();
  get pageController => _pageController;

  var _quizLoading = false;
  get quizLoading => _quizLoading;

  var _tags = <Tag>[];
  get tags => _tags;

  var _categories = <Category>[];
  get categories => _categories;

  var _questions = <Question>[];
  get questions => _questions;

  var _allAnswers = <bool>[];

  var _selectedQuestionIndex = 0;
  get selectedQuestionIndex => _selectedQuestionIndex;

  var _score = 0;
  get score => _score;

  var _currentTopic = "";
  get currentTopic => _currentTopic;

  var _currentDifficulty = "";
  get currentDifficulty => _currentDifficulty;

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

  Future<void> _getQuestions(
      String category, String difficulty, Function(String) showSnackbar) async {
    try {
      _questions = await _repo.getQuestions(category, difficulty);
      notifyListeners();
    } catch (e) {
      showSnackbar(e.toString());
    }
  }

  Future<void> nextQuestion(bool wasPreviousCorrect) async {
    if (wasPreviousCorrect) {
      _score++;
      notifyListeners();
    }
    _pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }



  Future<String> startQuiz(
      {required String category,
      required String difficulty,
      required Null Function(dynamic msg) showSnackbar}) async {
    _currentTopic = category;
    _currentDifficulty = difficulty;
    _quizLoading = true;
    _allAnswers = [];
    await _getQuestions(category, difficulty, showSnackbar);
    notifyListeners();
    _quizLoading = false;
    _pageController.jumpToPage(1);
    return "1/${_questions.length}";
  }

  Future<void> finishQuiz() async {
    var userId = _auth.currentUser?.uid;
    if(userId != null) _repo.saveScore(userId, _score, _currentTopic, _currentDifficulty);
  }
}
