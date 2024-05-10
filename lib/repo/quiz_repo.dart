import 'package:mad_quiz_app/api_services/api_service.dart';
import 'package:mad_quiz_app/models/category.dart';
import 'package:mad_quiz_app/models/question.dart';
import 'package:mad_quiz_app/models/tag.dart';

class QuizRepo {
  final _apiService = ApiService();


  Future<List<Tag>> getTags() async {
    return await _apiService.getTags();
  }

  Future<List<Category>> getCategories() async {
    return await _apiService.getCategories();
  }

  Future<List<Question>> getQuestions() async {
    return await _apiService.getQuestions();
  }
}