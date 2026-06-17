import 'package:flutter/foundation.dart';

import '../data/models/statistics_model.dart';
import '../data/repositories/question_repository.dart';

class HomeController extends ChangeNotifier {
  HomeController(this._repository);

  final QuestionRepository _repository;

  bool _isLoading = false;
  String? _errorMessage;
  StatisticsModel? _statistics;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  StatisticsModel? get statistics => _statistics;

  Future<void> loadStatistics() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _statistics = await _repository.getStatistics();
    } catch (error) {
      _errorMessage = 'Không tải được dữ liệu thống kê';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
