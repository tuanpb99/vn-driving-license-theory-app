import '../../domain/entities/answer.dart';
import '../../domain/entities/question.dart';

class QuestionDto {
  const QuestionDto({
    required this.id,
    required this.category,
    required this.question,
    required this.answers,
    required this.explanation,
    required this.memoryTips,
    required this.critical,
    this.image,
  });

  final String id;
  final String category;
  final String question;
  final String? image;
  final List<AnswerDto> answers;
  final String explanation;
  final String memoryTips;
  final bool critical;

  factory QuestionDto.fromJson(Map<String, dynamic> json) => QuestionDto(
        id: json['id'] as String,
        category: json['category'] as String,
        question: json['question'] as String,
        image: json['image'] as String?,
        answers: (json['answers'] as List<dynamic>)
            .map((e) => AnswerDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        explanation: json['explanation'] as String,
        memoryTips: json['memoryTips'] as String,
        critical: json['critical'] as bool? ?? false,
      );

  Question toDomain() => Question(
        id: id,
        category: category,
        text: question,
        image: image,
        answers: answers.map((e) => e.toDomain()).toList(),
        explanation: explanation,
        memoryTips: memoryTips,
        isCritical: critical,
      );
}

class AnswerDto {
  const AnswerDto({
    required this.text,
    required this.isCorrect,
    this.image,
  });

  final String text;
  final bool isCorrect;
  final String? image;

  factory AnswerDto.fromJson(Map<String, dynamic> json) => AnswerDto(
        text: json['text'] as String,
        image: json['image'] as String?,
        isCorrect: json['isCorrect'] as bool,
      );

  Answer toDomain() => Answer(text: text, isCorrect: isCorrect, image: image);
}
