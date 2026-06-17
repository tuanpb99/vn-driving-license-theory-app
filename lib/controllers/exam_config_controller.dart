import 'package:flutter/foundation.dart';

import '../data/models/exam_models.dart';

class ExamConfigController extends ChangeNotifier {
  bool _autoNext = false;
  bool _scoreAfterSubmit = true;
  int _totalQuestions = 30;
  int _criticalQuestions = 5;
  int _questionsWithImages = 3;

  bool get autoNext => _autoNext;
  bool get scoreAfterSubmit => _scoreAfterSubmit;
  int get totalQuestions => _totalQuestions;
  int get criticalQuestions => _criticalQuestions;
  int get questionsWithImages => _questionsWithImages;

  ExamConfigRequest get request => ExamConfigRequest(
        totalQuestions: _totalQuestions,
        criticalQuestions: _criticalQuestions,
        questionsWithImages: _questionsWithImages,
      );

  void setAutoNext(bool value) {
    _autoNext = value;
    notifyListeners();
  }

  void setScoreAfterSubmit(bool value) {
    _scoreAfterSubmit = value;
    notifyListeners();
  }

  void setTotalQuestions(int value) {
    _totalQuestions = value;
    notifyListeners();
  }

  void setCriticalQuestions(int value) {
    _criticalQuestions = value;
    notifyListeners();
  }

  void setQuestionsWithImages(int value) {
    _questionsWithImages = value;
    notifyListeners();
  }
}
