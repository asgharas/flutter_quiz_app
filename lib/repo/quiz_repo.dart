import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mad_quiz_app/api_services/api_service.dart';
import 'package:mad_quiz_app/models/category.dart';
import 'package:mad_quiz_app/models/question.dart';
import 'package:mad_quiz_app/models/tag.dart';

class QuizRepo {
  final _apiService = ApiService();
  final firestore = FirebaseFirestore.instance;


  Future<List<Tag>> getTags() async {
    return await _apiService.getTags();
  }

  Future<List<Category>> getCategories() async {
    return await _apiService.getCategories();
  }

  Future<List<Question>> getQuestions(String category, String difficulty) async {
    return await _apiService.getQuestions(category, difficulty);
  }

  Future<void> saveScore(String userId, String email, int score, String category, String difficulty) async {
    await firestore.collection('scores').add({
      'userId': userId,
      'email': email,
      'score': score,
      'category': category,
      'difficulty': difficulty,
      'timestamp': DateTime.now(),
    });
  } 
  
}