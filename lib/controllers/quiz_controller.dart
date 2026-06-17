import 'package:flutter/foundation.dart';

import '../data/models/exam_models.dart';
import '../data/models/question_model.dart';
import '../data/repositories/question_repository.dart';

class QuizController extends ChangeNotifier {
  QuizController(this._repository);

  final QuestionRepository _repository;

  bool _isLoading = false;
  String? _errorMessage;
  List<QuestionModel> _questions = const [];
  int _currentIndex = 0;
  final Map<int, int> _selectedAnswers = {};

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<QuestionModel> get questions => _questions;
  int get currentIndex => _currentIndex;
  int get totalQuestions => _questions.length;
  QuestionModel? get currentQuestion =>
      _questions.isEmpty ? null : _questions[_currentIndex];
  int? get selectedAnswer => _selectedAnswers[_currentIndex];

  Future<void> loadExam(ExamConfigRequest config) async {
    await _load(() async {
      final exam = await _repository.generateExam(config);
      return exam.questions;
    });
  }

  Future<void> loadRandomQuestions({int count = 30}) async {
    await _load(() => _repository.getRandomQuestions(count: count));
  }

  Future<void> _load(Future<List<QuestionModel>> Function() request) async {
    _isLoading = true;
    _errorMessage = null;
    _currentIndex = 0;
    _selectedAnswers.clear();
    notifyListeners();

    try {
      _questions = await request();
      if (_questions.isEmpty) {
        _errorMessage = 'Không có câu hỏi nào';
      }
    } catch (error) {
      _errorMessage = 'Không tải được câu hỏi từ server';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectQuestion(int index) {
    if (index < 0 || index >= _questions.length) return;
    _currentIndex = index;
    notifyListeners();
  }

  void selectAnswer(int index) {
    if (_selectedAnswers.containsKey(_currentIndex)) return;
    _selectedAnswers[_currentIndex] = index;
    notifyListeners();
  }

  void previousQuestion() {
    if (_currentIndex == 0) return;
    _currentIndex--;
    notifyListeners();
  }

  void nextQuestion() {
    if (_questions.isEmpty) return;
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
    }
    notifyListeners();
  }
}
