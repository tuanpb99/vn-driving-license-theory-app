import '../models/exam_models.dart';
import '../models/question_list_response.dart';
import '../models/question_model.dart';
import '../models/statistics_model.dart';
import '../services/question_api_service.dart';

class QuestionRepository {
  const QuestionRepository(this._api);

  final QuestionApiService _api;

  Future<QuestionListResponse> getQuestions({
    int page = 1,
    int pageSize = 20,
    String? category,
  }) {
    return _api.getQuestions(
      page: page,
      pageSize: pageSize,
      category: category,
    );
  }

  Future<List<QuestionModel>> getRandomQuestions({
    int count = 30,
    String? category,
  }) async {
    if (category != null) {
      final response = await _api.getQuestions(
        page: 1,
        pageSize: count,
        category: category,
      );
      return response.questions;
    }

    final exam = await _api.generateExam(
      ExamConfigRequest(
        totalQuestions: count,
        criticalQuestions: 0,
        questionsWithImages: 0,
      ),
    );
    return exam.questions;
  }

  Future<ExamResponse> generateExam(ExamConfigRequest config) {
    return _api.generateExam(config);
  }

  Future<StatisticsModel> getStatistics() {
    return _api.getStatistics();
  }
}
