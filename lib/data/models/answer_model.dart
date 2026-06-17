import 'package:json_annotation/json_annotation.dart';

part 'answer_model.g.dart';

@JsonSerializable()
class AnswerModel {
  const AnswerModel({
    required this.text,
    required this.correct,
  });

  final String text;
  final bool correct;

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerModelToJson(this);
}
