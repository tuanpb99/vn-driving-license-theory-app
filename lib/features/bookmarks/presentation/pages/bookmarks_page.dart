import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../../questions/presentation/controllers/questions_controller.dart';

class BookmarksPage extends ConsumerWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksProvider).value ?? <String>{};
    final questions = ref.watch(questionsControllerProvider).value ?? [];
    final items = questions.where((q) => bookmarks.contains(q.id)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Câu hỏi đã đánh dấu')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(items[index].text),
          subtitle: Text(items[index].category),
        ),
      ),
    );
  }
}
