import 'package:json_annotation/json_annotation.dart';

import 'answer_model.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  const QuestionModel({
    required this.number,
    required this.question,
    required this.category,
    required this.answers,
    required this.explanation,
    this.hinhanhq,
    this.hinhanhqAlt,
  });

  final int number;
  final String question;
  final String category;
  final List<AnswerModel> answers;
  final String explanation;
  final String? hinhanhq;
  final String? hinhanhqAlt;

  bool get isCritical => category.contains('diem-liet');
  bool get hasImage => hinhanhq != null && hinhanhq!.isNotEmpty;
  int get correctIndex => answers.indexWhere((answer) => answer.correct);

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
