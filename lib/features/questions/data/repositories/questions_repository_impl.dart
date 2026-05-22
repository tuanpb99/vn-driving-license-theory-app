import '../../domain/entities/question.dart';
import '../../domain/repositories/questions_repository.dart';
import '../datasources/questions_local_data_source.dart';
import '../datasources/questions_remote_data_source.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  QuestionsRepositoryImpl({
    required QuestionsRemoteDataSource remote,
    required QuestionsLocalDataSource local,
  })  : _remote = remote,
        _local = local;

  final QuestionsRemoteDataSource _remote;
  final QuestionsLocalDataSource _local;

  @override
  Future<List<Question>> getAllQuestions({bool forceRefresh = false}) async {
    final localQuestions = await _local.getQuestions();
    if (localQuestions.isNotEmpty && !forceRefresh) {
      return localQuestions;
    }

    final remoteQuestions = (await _remote.fetchQuestions()).map((e) => e.toDomain()).toList();
    await _local.saveQuestions(remoteQuestions);
    return remoteQuestions;
  }

  @override
  Future<List<Question>> getByCategory(String category) async {
    final questions = await getAllQuestions();
    return questions.where((q) => q.category == category).toList();
  }

  @override
  Future<List<Question>> search(String keyword) async {
    final questions = await getAllQuestions();
    final needle = keyword.toLowerCase().trim();
    return questions
        .where((q) =>
            q.text.toLowerCase().contains(needle) ||
            q.explanation.toLowerCase().contains(needle) ||
            q.memoryTips.toLowerCase().contains(needle))
        .toList();
  }

  @override
  Future<void> toggleBookmark(String questionId) => _local.toggleBookmark(questionId);

  @override
  Future<Set<String>> getBookmarks() => _local.getBookmarks();

  @override
  Future<List<Question>> getWrongQuestions() async {
    final questions = await getAllQuestions();
    final wrongIds = await _local.getWrongQuestionIds();
    return questions.where((q) => wrongIds.contains(q.id)).toList();
  }

  @override
  Future<void> recordResult({required String questionId, required bool isCorrect}) {
    return _local.recordResult(questionId: questionId, isCorrect: isCorrect);
  }
}
