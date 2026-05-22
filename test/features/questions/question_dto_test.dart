import 'package:flutter_test/flutter_test.dart';
import 'package:vn_driving_license_theory_app/features/questions/data/dto/question_dto.dart';

void main() {
  test('QuestionDto parses expected fields', () {
    final dto = QuestionDto.fromJson({
      'id': 'q1',
      'category': 'cat',
      'question': 'question?',
      'image': null,
      'answers': [
        {'text': 'A', 'image': null, 'isCorrect': true},
        {'text': 'B', 'image': null, 'isCorrect': false},
      ],
      'explanation': 'exp',
      'memoryTips': 'tip',
      'critical': true,
    });

    final question = dto.toDomain();
    expect(question.id, 'q1');
    expect(question.answers.length, 2);
    expect(question.isCritical, isTrue);
    expect(question.isCorrectAnswer(0), isTrue);
  });
}
