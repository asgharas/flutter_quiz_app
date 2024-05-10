import 'package:http/http.dart' as http;
import 'package:mad_quiz_app/models/category.dart';
import 'package:mad_quiz_app/models/question.dart';
import 'package:mad_quiz_app/models/tag.dart';

class ApiService {
  final String _baseUrl = "https://quizapi.io/api/v1";
  final String _tagsEndpoint = "/tags";
  final String _categoriesEndpoint = "/categories";
  final String _questionsEndpoint = "/questions";
  final String _apiKey = "OGhQT2xCTwzVteTrUjgf5Wcfe3nwfWelKPqjYZNF";

  // get tags
  Future<List<Tag>> getTags() async {
    final response = await http.get(Uri.parse("$_baseUrl$_tagsEndpoint"),
        headers: {"X-Api-Key": _apiKey});
    if (response.statusCode == 200) {
      return tagsFromJson(response.body);
    } else {
      throw Exception("Failed to load tags");
    }
  }

  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse("$_baseUrl$_categoriesEndpoint"),
        headers: {"X-Api-Key": _apiKey});
    if (response.statusCode == 200) {
      return categoriesFromJson(response.body);
    } else {
      throw Exception("Failed to load categories");
    }
  }

  // get questions
  Future<List<Question>> getQuestions() async {
    final response = await http.get(Uri.parse("$_baseUrl$_questionsEndpoint"),
        headers: {"X-Api-Key": _apiKey});
    if (response.statusCode == 200) {
      return questionsFromJson(response.body);
    } else {
      throw Exception("Failed to load questions");
    }
  }
}
