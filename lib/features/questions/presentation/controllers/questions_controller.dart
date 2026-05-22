import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../domain/entities/question.dart';
import '../../domain/usecases/get_questions_usecase.dart';

class QuestionsController extends AsyncNotifier<List<Question>> {
  late final GetQuestionsUseCase _getQuestionsUseCase;

  @override
  Future<List<Question>> build() async {
    _getQuestionsUseCase = ref.read(getQuestionsUseCaseProvider);
    return _getQuestionsUseCase();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _getQuestionsUseCase(forceRefresh: true));
  }
}

final questionsControllerProvider = AsyncNotifierProvider<QuestionsController, List<Question>>(QuestionsController.new);
