import 'package:flutter_test/flutter_test.dart';
import 'package:vn_driving_license_theory_app/features/exams/presentation/controllers/exam_controller.dart';
import 'package:vn_driving_license_theory_app/features/questions/domain/entities/answer.dart';
import 'package:vn_driving_license_theory_app/features/questions/domain/entities/question.dart';

void main() {
  test('ExamState computes correct answers', () {
    const questions = [
      Question(
        id: '1',
        category: 'cat',
        text: 'Q1',
        answers: [
          Answer(text: 'A1', isCorrect: true),
          Answer(text: 'A2', isCorrect: false),
        ],
        explanation: '',
        memoryTips: '',
        isCritical: false,
      ),
      Question(
        id: '2',
        category: 'cat',
        text: 'Q2',
        answers: [
          Answer(text: 'A1', isCorrect: false),
          Answer(text: 'A2', isCorrect: true),
        ],
        explanation: '',
        memoryTips: '',
        isCritical: false,
      ),
    ];

    const state = ExamState(
      questions: questions,
      selected: {'1': 0, '2': 0},
      currentIndex: 0,
      remainingSeconds: 100,
      isSubmitted: false,
    );

    expect(state.correctCount, 1);
  });
}
