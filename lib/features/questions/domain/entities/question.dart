import 'answer.dart';

class Question {
  const Question({
    required this.id,
    required this.category,
    required this.text,
    required this.answers,
    required this.explanation,
    required this.memoryTips,
    required this.isCritical,
    this.image,
  });

  final String id;
  final String category;
  final String text;
  final String? image;
  final List<Answer> answers;
  final String explanation;
  final String memoryTips;
  final bool isCritical;

  bool isCorrectAnswer(int index) => answers[index].isCorrect;
}
