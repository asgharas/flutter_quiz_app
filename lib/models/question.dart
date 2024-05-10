import 'dart:convert';

class Question {
  int id;
  String question;
  String description;
  Answers answers;
  String multipleCorrectAnswers;
  CorrectAnswers correctAnswers;
  String correctAnswer;
  String explanation;
  String tip;
  String category;
  String difficulty;

  Question({
    required this.id,
    required this.question,
    required this.description,
    required this.answers,
    required this.multipleCorrectAnswers,
    required this.correctAnswers,
    required this.correctAnswer,
    required this.explanation,
    required this.tip,
    required this.category,
    required this.difficulty,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      description: json['description'],
      answers: Answers.fromJson(json['answers']),
      multipleCorrectAnswers: json['multiple_correct_answers'],
      correctAnswers: CorrectAnswers.fromJson(json['correct_answers']),
      correctAnswer: json['correct_answer'],
      explanation: json['explanation'],
      tip: json['tip'],
      category: json['category'],
      difficulty: json['difficulty'],
    );
  }
}

class Answers {
  String answerA;
  String answerB;
  String answerC;
  String answerD;
  String answerE;
  String answerF;

  Answers({
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
    required this.answerE,
    required this.answerF,
  });

  factory Answers.fromJson(Map<String, dynamic> json) {
    return Answers(
      answerA: json['answer_a'],
      answerB: json['answer_b'],
      answerC: json['answer_c'],
      answerD: json['answer_d'],
      answerE: json['answer_e'],
      answerF: json['answer_f'],
    );
  }
}

class CorrectAnswers {
  String answerACorrect;
  String answerBCorrect;
  String answerCCorrect;
  String answerDCorrect;
  String answerECorrect;
  String answerFCorrect;

  CorrectAnswers({
    required this.answerACorrect,
    required this.answerBCorrect,
    required this.answerCCorrect,
    required this.answerDCorrect,
    required this.answerECorrect,
    required this.answerFCorrect,
  });

  factory CorrectAnswers.fromJson(Map<String, dynamic> json) {
    return CorrectAnswers(
      answerACorrect: json['answer_a_correct'],
      answerBCorrect: json['answer_b_correct'],
      answerCCorrect: json['answer_c_correct'],
      answerDCorrect: json['answer_d_correct'],
      answerECorrect: json['answer_e_correct'],
      answerFCorrect: json['answer_f_correct'],
    );
  }
}


List<Question> questionsFromJson(String str) =>
    List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));