import 'package:json_annotation/json_annotation.dart';

import 'question_model.dart';

part 'exam_models.g.dart';

@JsonSerializable()
class ExamConfigRequest {
  const ExamConfigRequest({
    this.totalQuestions = 30,
    this.criticalQuestions = 5,
    this.questionsWithImages = 3,
  });

  @JsonKey(name: 'total_questions')
  final int totalQuestions;

  @JsonKey(name: 'critical_questions')
  final int criticalQuestions;

  @JsonKey(name: 'questions_with_images')
  final int questionsWithImages;

  factory ExamConfigRequest.fromJson(Map<String, dynamic> json) =>
      _$ExamConfigRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExamConfigRequestToJson(this);
}

@JsonSerializable()
class ExamResponse {
  const ExamResponse({
    required this.examId,
    required this.totalQuestions,
    required this.criticalQuestions,
    required this.questionsWithImages,
    required this.questions,
  });

  @JsonKey(name: 'exam_id')
  final String examId;

  @JsonKey(name: 'total_questions')
  final int totalQuestions;

  @JsonKey(name: 'critical_questions')
  final int criticalQuestions;

  @JsonKey(name: 'questions_with_images')
  final int questionsWithImages;

  final List<QuestionModel> questions;

  factory ExamResponse.fromJson(Map<String, dynamic> json) =>
      _$ExamResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExamResponseToJson(this);
}
