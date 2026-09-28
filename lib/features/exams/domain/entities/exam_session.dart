class ExamSession {
  const ExamSession({
    required this.total,
    required this.correct,
    required this.durationSeconds,
  });

  final int total;
  final int correct;
  final int durationSeconds;

  double get score => total == 0 ? 0 : correct / total;
}
