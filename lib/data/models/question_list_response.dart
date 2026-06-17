import 'package:json_annotation/json_annotation.dart';

import 'question_model.dart';

part 'question_list_response.g.dart';

@JsonSerializable()
class QuestionListResponse {
  const QuestionListResponse({
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.questions,
  });

  final int total;
  final int page;

  @JsonKey(name: 'page_size')
  final int pageSize;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  final List<QuestionModel> questions;

  factory QuestionListResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionListResponseToJson(this);
}
