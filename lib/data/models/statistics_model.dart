import 'package:json_annotation/json_annotation.dart';

part 'statistics_model.g.dart';

@JsonSerializable()
class StatisticsModel {
  const StatisticsModel({
    required this.total,
    required this.totalCategories,
    required this.categories,
    required this.questionsWithImages,
    required this.criticalQuestions,
    required this.categoryBreakdown,
  });

  final int total;

  @JsonKey(name: 'total_categories')
  final int totalCategories;

  final List<String> categories;

  @JsonKey(name: 'questions_with_images')
  final int questionsWithImages;

  @JsonKey(name: 'critical_questions')
  final int criticalQuestions;

  @JsonKey(name: 'category_breakdown')
  final List<CategoryBreakdownModel> categoryBreakdown;

  factory StatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$StatisticsModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsModelToJson(this);
}

@JsonSerializable()
class CategoryBreakdownModel {
  const CategoryBreakdownModel({
    required this.category,
    required this.count,
  });

  final String category;
  final int count;

  factory CategoryBreakdownModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryBreakdownModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryBreakdownModelToJson(this);
}
