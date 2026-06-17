// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionListResponse _$QuestionListResponseFromJson(
        Map<String, dynamic> json) =>
    QuestionListResponse(
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['page_size'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionListResponseToJson(
        QuestionListResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'page_size': instance.pageSize,
      'total_pages': instance.totalPages,
      'questions': instance.questions,
    };
