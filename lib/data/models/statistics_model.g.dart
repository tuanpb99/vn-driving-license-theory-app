// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticsModel _$StatisticsModelFromJson(Map<String, dynamic> json) =>
    StatisticsModel(
      total: (json['total'] as num).toInt(),
      totalCategories: (json['total_categories'] as num).toInt(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      questionsWithImages: (json['questions_with_images'] as num).toInt(),
      criticalQuestions: (json['critical_questions'] as num).toInt(),
      categoryBreakdown: (json['category_breakdown'] as List<dynamic>)
          .map(
              (e) => CategoryBreakdownModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatisticsModelToJson(StatisticsModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'total_categories': instance.totalCategories,
      'categories': instance.categories,
      'questions_with_images': instance.questionsWithImages,
      'critical_questions': instance.criticalQuestions,
      'category_breakdown': instance.categoryBreakdown,
    };

CategoryBreakdownModel _$CategoryBreakdownModelFromJson(
        Map<String, dynamic> json) =>
    CategoryBreakdownModel(
      category: json['category'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$CategoryBreakdownModelToJson(
        CategoryBreakdownModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'count': instance.count,
    };
