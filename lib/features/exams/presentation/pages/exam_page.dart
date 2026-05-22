import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/exam_controller.dart';

class ExamPage extends ConsumerWidget {
  const ExamPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(examControllerProvider);
    final notifier = ref.read(examControllerProvider.notifier);

    if (state.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Thi thử ngẫu nhiên')),
        body: Center(
          child: FilledButton(
            onPressed: () => notifier.startRandomExam(),
            child: const Text('Bắt đầu thi 20 câu'),
          ),
        ),
      );
    }

    final current = state.questions[state.currentIndex];
    final selected = state.selected[current.id];

    return Scaffold(
      appBar: AppBar(
        title: Text('Thi thử - còn ${state.remainingSeconds}s'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Câu ${state.currentIndex + 1}/${state.questions.length}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(current.text),
            const SizedBox(height: 12),
            for (var i = 0; i < current.answers.length; i++)
              RadioListTile<int>(
                value: i,
                groupValue: selected,
                onChanged: state.isSubmitted ? null : (value) => notifier.selectAnswer(value!),
                title: Text(current.answers[i].text),
              ),
            if (state.isSubmitted)
              Text('Kết quả: ${state.correctCount}/${state.questions.length}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: state.currentIndex < state.questions.length - 1 ? notifier.next : null,
                    child: const Text('Câu tiếp'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton(
                    onPressed: state.isSubmitted ? null : notifier.submit,
                    child: const Text('Nộp bài'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
