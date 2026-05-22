import '../entities/question.dart';

abstract class QuestionsRepository {
  Future<List<Question>> getAllQuestions({bool forceRefresh = false});
  Future<List<Question>> getByCategory(String category);
  Future<List<Question>> search(String keyword);
  Future<void> toggleBookmark(String questionId);
  Future<Set<String>> getBookmarks();
  Future<List<Question>> getWrongQuestions();
  Future<void> recordResult({required String questionId, required bool isCorrect});
}
