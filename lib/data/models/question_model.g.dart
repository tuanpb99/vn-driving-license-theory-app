// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      number: (json['number'] as num).toInt(),
      question: json['question'] as String,
      category: json['category'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      explanation: json['explanation'] as String,
      hinhanhq: json['hinhanhq'] as String?,
      hinhanhqAlt: json['hinhanhqAlt'] as String?,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'number': instance.number,
      'question': instance.question,
      'category': instance.category,
      'answers': instance.answers,
      'explanation': instance.explanation,
      'hinhanhq': instance.hinhanhq,
      'hinhanhqAlt': instance.hinhanhqAlt,
    };
