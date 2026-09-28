// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamConfigRequest _$ExamConfigRequestFromJson(Map<String, dynamic> json) =>
    ExamConfigRequest(
      totalQuestions: (json['total_questions'] as num?)?.toInt() ?? 30,
      criticalQuestions: (json['critical_questions'] as num?)?.toInt() ?? 5,
      questionsWithImages:
          (json['questions_with_images'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$ExamConfigRequestToJson(ExamConfigRequest instance) =>
    <String, dynamic>{
      'total_questions': instance.totalQuestions,
      'critical_questions': instance.criticalQuestions,
      'questions_with_images': instance.questionsWithImages,
    };

ExamResponse _$ExamResponseFromJson(Map<String, dynamic> json) => ExamResponse(
      examId: json['exam_id'] as String,
      totalQuestions: (json['total_questions'] as num).toInt(),
      criticalQuestions: (json['critical_questions'] as num).toInt(),
      questionsWithImages: (json['questions_with_images'] as num).toInt(),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamResponseToJson(ExamResponse instance) =>
    <String, dynamic>{
      'exam_id': instance.examId,
      'total_questions': instance.totalQuestions,
      'critical_questions': instance.criticalQuestions,
      'questions_with_images': instance.questionsWithImages,
      'questions': instance.questions,
    };
