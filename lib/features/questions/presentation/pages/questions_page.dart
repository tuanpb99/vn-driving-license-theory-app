import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../controllers/questions_controller.dart';

class QuestionsPage extends ConsumerStatefulWidget {
  const QuestionsPage({super.key});

  @override
  ConsumerState<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends ConsumerState<QuestionsPage> {
  String _keyword = '';

  @override
  Widget build(BuildContext context) {
    final asyncQuestions = ref.watch(questionsControllerProvider);
    final bookmarksAsync = ref.watch(bookmarksProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Học theo chủ đề')),
      body: asyncQuestions.when(
        data: (questions) {
          final filtered = questions.where((q) {
            final needle = _keyword.toLowerCase();
            return needle.isEmpty ||
                q.text.toLowerCase().contains(needle) ||
                q.category.toLowerCase().contains(needle);
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Tìm kiếm câu hỏi',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) => setState(() => _keyword = value),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final q = filtered[index];
                    final bookmarks = bookmarksAsync.value ?? <String>{};
                    final bookmarked = bookmarks.contains(q.id);

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ExpansionTile(
                        title: Text('${q.category}: ${q.text}'),
                        subtitle: q.isCritical ? const Text('Câu điểm liệt') : null,
                        trailing: IconButton(
                          onPressed: () => ref.read(questionsActionsProvider).toggleBookmark(q.id),
                          icon: Icon(bookmarked ? Icons.bookmark : Icons.bookmark_border),
                        ),
                        children: [
                          for (final a in q.answers)
                            ListTile(
                              title: Text(a.text),
                              leading: a.isCorrect ? const Icon(Icons.check, color: Colors.green) : null,
                            ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Giải thích: ${q.explanation}'),
                                const SizedBox(height: 8),
                                Text('Mẹo nhớ: ${q.memoryTips}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => Center(child: Text('Lỗi: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
