import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../features/questions/data/datasources/questions_local_data_source.dart';
import '../../features/questions/data/datasources/questions_remote_data_source.dart';
import '../../features/questions/data/repositories/questions_repository_impl.dart';
import '../../features/questions/domain/repositories/questions_repository.dart';
import '../../features/questions/domain/usecases/get_questions_usecase.dart';
import '../network/mock_api_service.dart';
import '../network/remote_sync_service.dart';
import '../services/ads_service.dart';
import '../services/notification_service.dart';

class AppBootstrapState {
  const AppBootstrapState();
}

final bootstrapProvider = Provider<AppBootstrapState>((ref) => const AppBootstrapState());

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final mockApiServiceProvider = Provider<MockApiService>((ref) => const MockApiService());

final remoteSyncServiceProvider = Provider<RemoteSyncService>((ref) {
  return RemoteSyncService(client: ref.watch(httpClientProvider));
});

final questionsRemoteProvider = Provider<QuestionsRemoteDataSource>((ref) {
  return QuestionsRemoteDataSource(ref.watch(mockApiServiceProvider));
});

final questionsLocalProvider = Provider<QuestionsLocalDataSource>((ref) {
  return QuestionsLocalDataSource();
});

final questionsRepositoryProvider = Provider<QuestionsRepository>((ref) {
  return QuestionsRepositoryImpl(
    remote: ref.watch(questionsRemoteProvider),
    local: ref.watch(questionsLocalProvider),
  );
});

final getQuestionsUseCaseProvider = Provider<GetQuestionsUseCase>((ref) {
  return GetQuestionsUseCase(ref.watch(questionsRepositoryProvider));
});

class QuestionsActions {
  QuestionsActions(this._repository);

  final QuestionsRepository _repository;

  Future<void> toggleBookmark(String questionId) => _repository.toggleBookmark(questionId);

  Future<void> recordResult({required String questionId, required bool isCorrect}) {
    return _repository.recordResult(questionId: questionId, isCorrect: isCorrect);
  }
}

final questionsActionsProvider = Provider<QuestionsActions>((ref) {
  return QuestionsActions(ref.watch(questionsRepositoryProvider));
});

final bookmarksProvider = FutureProvider<Set<String>>((ref) {
  return ref.watch(questionsRepositoryProvider).getBookmarks();
});

class StatisticsSummary {
  const StatisticsSummary({
    required this.totalExams,
    required this.avgCorrect,
    required this.wrongQuestionsCount,
  });

  final int totalExams;
  final double avgCorrect;
  final int wrongQuestionsCount;
}

final statisticsProvider = FutureProvider<StatisticsSummary>((ref) async {
  final repo = ref.watch(questionsRepositoryProvider);
  final wrongQuestions = await repo.getWrongQuestions();
  return StatisticsSummary(
    totalExams: 0,
    avgCorrect: 0,
    wrongQuestionsCount: wrongQuestions.length,
  );
});

final notificationServiceProvider = Provider<NotificationService>((ref) => NotificationService());

class NotificationAction {
  NotificationAction(this._service);

  final NotificationService _service;

  Future<void> scheduleReminder() async {
    await _service.initialize();
    await _service.scheduleDailyReminder(
      id: 100,
      title: 'Ôn thi GPLX',
      body: 'Hãy dành 15 phút để luyện đề hôm nay nhé!',
    );
  }
}

final notificationActionProvider = Provider<NotificationAction>((ref) {
  return NotificationAction(ref.watch(notificationServiceProvider));
});

final adsServiceProvider = Provider<AdsService>((ref) => AdsService());

class AdsAction {
  AdsAction(this._service);

  final AdsService _service;

  Future<void> initialize() => _service.initialize();
}

final adsActionProvider = Provider<AdsAction>((ref) => AdsAction(ref.watch(adsServiceProvider)));
