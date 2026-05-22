import '../../../../core/network/mock_api_service.dart';
import '../dto/question_dto.dart';

class QuestionsRemoteDataSource {
  const QuestionsRemoteDataSource(this._apiService);

  final MockApiService _apiService;

  Future<List<QuestionDto>> fetchQuestions() async {
    final payload = await _apiService.fetchQuestionsPayload();
    final items = payload['questions'] as List<dynamic>;
    return items
        .map((e) => QuestionDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
