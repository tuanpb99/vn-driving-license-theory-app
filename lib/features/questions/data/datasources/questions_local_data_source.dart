import '../../domain/entities/question.dart';

class QuestionsLocalDataSource {
  List<Question> _cache = const [];
  final Set<String> _bookmarks = <String>{};
  final Set<String> _wrongQuestionIds = <String>{};

  Future<void> saveQuestions(List<Question> questions) async {
    _cache = questions;
  }

  Future<List<Question>> getQuestions() async => _cache;

  Future<void> toggleBookmark(String questionId) async {
    if (_bookmarks.contains(questionId)) {
      _bookmarks.remove(questionId);
    } else {
      _bookmarks.add(questionId);
    }
  }

  Future<Set<String>> getBookmarks() async => _bookmarks;

  Future<void> recordResult({required String questionId, required bool isCorrect}) async {
    if (isCorrect) {
      _wrongQuestionIds.remove(questionId);
    } else {
      _wrongQuestionIds.add(questionId);
    }
  }

  Future<Set<String>> getWrongQuestionIds() async => _wrongQuestionIds;
}
