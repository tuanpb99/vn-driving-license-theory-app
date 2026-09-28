class Answer {
  const Answer({
    required this.text,
    required this.isCorrect,
    this.image,
  });

  final String text;
  final bool isCorrect;
  final String? image;
}
