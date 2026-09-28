import '../entities/question.dart';
import '../repositories/questions_repository.dart';

class GetQuestionsUseCase {
  const GetQuestionsUseCase(this.repository);

  final QuestionsRepository repository;

  Future<List<Question>> call({bool forceRefresh = false}) => repository.getAllQuestions(forceRefresh: forceRefresh);
}
