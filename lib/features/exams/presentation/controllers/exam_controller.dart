import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../../questions/domain/entities/question.dart';
import '../../../questions/domain/repositories/questions_repository.dart';

class ExamState {
  const ExamState({
    required this.questions,
    required this.selected,
    required this.currentIndex,
    required this.remainingSeconds,
    required this.isSubmitted,
  });

  final List<Question> questions;
  final Map<String, int> selected;
  final int currentIndex;
  final int remainingSeconds;
  final bool isSubmitted;

  int get correctCount {
    var correct = 0;
    for (final q in questions) {
      final selectedIndex = selected[q.id];
      if (selectedIndex != null && q.isCorrectAnswer(selectedIndex)) {
        correct++;
      }
    }
    return correct;
  }

  ExamState copyWith({
    List<Question>? questions,
    Map<String, int>? selected,
    int? currentIndex,
    int? remainingSeconds,
    bool? isSubmitted,
  }) {
    return ExamState(
      questions: questions ?? this.questions,
      selected: selected ?? this.selected,
      currentIndex: currentIndex ?? this.currentIndex,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }
}

class ExamController extends StateNotifier<ExamState> {
  ExamController(this._repository)
      : super(
          const ExamState(
            questions: [],
            selected: {},
            currentIndex: 0,
            remainingSeconds: 1200,
            isSubmitted: false,
          ),
        );

  final QuestionsRepository _repository;
  Timer? _timer;

  Future<void> startRandomExam({int count = 20}) async {
    final all = await _repository.getAllQuestions();
    final random = [...all]..shuffle(Random());
    final selected = random.take(count).map(_shuffleAnswers).toList();

    state = state.copyWith(
      questions: selected,
      selected: {},
      currentIndex: 0,
      remainingSeconds: 1200,
      isSubmitted: false,
    );
    _startTimer();
  }

  Question _shuffleAnswers(Question q) {
    final answers = [...q.answers]..shuffle(Random());
    return Question(
      id: q.id,
      category: q.category,
      text: q.text,
      image: q.image,
      answers: answers,
      explanation: q.explanation,
      memoryTips: q.memoryTips,
      isCritical: q.isCritical,
    );
  }

  void selectAnswer(int index) {
    if (state.isSubmitted || state.questions.isEmpty) return;
    final question = state.questions[state.currentIndex];
    final map = {...state.selected, question.id: index};
    state = state.copyWith(selected: map);
  }

  void next() {
    if (state.currentIndex >= state.questions.length - 1) return;
    state = state.copyWith(currentIndex: state.currentIndex + 1);
  }

  Future<void> submit() async {
    _timer?.cancel();
    for (final q in state.questions) {
      final answer = state.selected[q.id];
      await _repository.recordResult(
        questionId: q.id,
        isCorrect: answer != null && q.isCorrectAnswer(answer),
      );
    }
    state = state.copyWith(isSubmitted: true);
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (state.remainingSeconds <= 1) {
        timer.cancel();
        await submit();
        return;
      }
      state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final examControllerProvider = StateNotifierProvider<ExamController, ExamState>((ref) {
  return ExamController(ref.read(questionsRepositoryProvider));
});
