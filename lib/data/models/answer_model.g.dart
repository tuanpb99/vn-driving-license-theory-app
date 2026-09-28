// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerModel _$AnswerModelFromJson(Map<String, dynamic> json) => AnswerModel(
      text: json['text'] as String,
      correct: json['correct'] as bool,
    );

Map<String, dynamic> _$AnswerModelToJson(AnswerModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'correct': instance.correct,
    };
