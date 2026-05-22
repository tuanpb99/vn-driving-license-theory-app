import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';

class StatisticsPage extends ConsumerWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(statisticsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Thống kê & lịch sử')),
      body: statsAsync.when(
        data: (stats) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tổng số lần thi: ${stats.totalExams}'),
              Text('Số câu đúng trung bình: ${stats.avgCorrect.toStringAsFixed(1)}'),
              Text('Số câu làm sai cần luyện lại: ${stats.wrongQuestionsCount}'),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Lỗi thống kê: $error')),
      ),
    );
  }
}
