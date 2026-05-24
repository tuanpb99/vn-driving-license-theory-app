import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const Color _cardBg = Color(0xFF2C2C2E);
  static const Color _screenBg = Color(0xFF1C1C1E);
  static const Color _optionBg = Color(0xFF2C2C2E);

  int _currentQuestion = 0;
  int? _selectedAnswer;
  final int _totalQuestions = 35;

  final List<_Question> _questions = const [
    _Question(
      text: 'Biển báo dưới đây có ý nghĩa gì?',
      options: [
        'Đường người đi bộ cắt ngang',
        'Nơi đường bộ giao nhau cùng mức với đường sắt',
        'Đường ưu tiên',
        'Cấm đi ngược chiều',
      ],
      correctIndex: 1,
      hasImage: true,
      badge: 'Điểm liệt',
    ),
    _Question(
      text: 'Tốc độ tối đa cho phép xe ô tô con đi trên đường cao tốc là bao nhiêu?',
      options: ['80 km/h', '100 km/h', '120 km/h', '140 km/h'],
      correctIndex: 2,
      hasImage: false,
      badge: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final q = _questions[_currentQuestion % _questions.length];
    return Scaffold(
      backgroundColor: _screenBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildQuestionGrid(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildQuestionHeader(),
                    _buildQuestionCard(q),
                    const SizedBox(height: AppSpacing.sm),
                    _buildAnswers(q),
                  ],
                ),
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, color: AppColors.primary, size: 22),
          ),
          Row(
            children: [
              _buildTimerBar(),
              const SizedBox(width: AppSpacing.md),
              Text('19:28',
                  style: AppTextStyles.nav
                      .copyWith(color: AppColors.primary)),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Text('Nộp bài',
                style: AppTextStyles.bodyLg
                    .copyWith(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerBar() {
    return SizedBox(
      width: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: LinearProgressIndicator(
          value: 0.6,
          minHeight: 6,
          backgroundColor: const Color(0xFF3A3A3C),
          valueColor:
              const AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildQuestionGrid() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      color: _cardBg,
      child: Column(
        children: [
          _buildGridRow(1, 15),
          const SizedBox(height: 4),
          _buildGridRow(16, 30),
        ],
      ),
    );
  }

  Widget _buildGridRow(int start, int end) {
    return Row(
      children: List.generate(end - start + 1, (i) {
        final num = start + i;
        final isCurrent = num == _currentQuestion + 1;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() {
              _currentQuestion = num - 1;
              _selectedAnswer = null;
            }),
            child: Container(
              height: 22,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isCurrent
                    ? Colors.transparent
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: isCurrent
                    ? Border.all(
                        color: AppColors.primary, width: 1.5)
                    : null,
              ),
              child: Center(
                child: Text(
                  '$num',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 11,
                    color: isCurrent
                        ? AppColors.primary
                        : const Color(0xFFAEAEB2),
                    fontWeight: isCurrent
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildQuestionHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Câu ${_currentQuestion + 1}',
              style: AppTextStyles.body
                  .copyWith(color: const Color(0xFFAEAEB2))),
          const Icon(Icons.bookmark_border_rounded,
              color: Color(0xFFAEAEB2), size: 20),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(_Question q) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (q.badge != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius:
                    BorderRadius.circular(AppSpacing.rFull),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: AppColors.accentRed, size: 14),
                  const SizedBox(width: 4),
                  Text(q.badge!,
                      style: AppTextStyles.labelSm.copyWith(
                          color: AppColors.accentRed,
                          fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          Text(q.text,
              style: AppTextStyles.bodyLg
                  .copyWith(fontWeight: FontWeight.w500)),
          if (q.hasImage) ...[
            const SizedBox(height: AppSpacing.lg),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A3C),
                borderRadius: BorderRadius.circular(AppSpacing.r12),
              ),
              child: const Center(
                child: Icon(Icons.image_rounded,
                    color: Color(0xFF636366), size: 40),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnswers(_Question q) {
    const labels = ['A', 'B', 'C', 'D'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        children: List.generate(q.options.length, (i) {
          final isSelected = _selectedAnswer == i;
          final isCorrect =
              _selectedAnswer != null && i == q.correctIndex;
          final isWrong = isSelected && i != q.correctIndex;

          Color borderColor = Colors.transparent;
          Color bgColor = _optionBg;
          Color labelBg = const Color(0xFF3A3A3C);
          Color labelColor = const Color(0xFFAEAEB2);

          if (isCorrect) {
            borderColor = AppColors.accentGreen;
            bgColor = AppColors.accentGreen.withOpacity(0.1);
            labelBg = AppColors.accentGreen.withOpacity(0.2);
            labelColor = AppColors.accentGreen;
          } else if (isWrong) {
            borderColor = AppColors.accentRed;
            bgColor = AppColors.accentRed.withOpacity(0.1);
            labelBg = AppColors.accentRed.withOpacity(0.2);
            labelColor = AppColors.accentRed;
          } else if (isSelected) {
            borderColor = AppColors.primary;
            labelBg = AppColors.bgCard;
            labelColor = AppColors.primary;
          }

          return GestureDetector(
            onTap: () {
              if (_selectedAnswer == null) {
                setState(() => _selectedAnswer = i);
              }
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm + 2),
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(AppSpacing.r12),
                border: Border.all(color: borderColor, width: 2),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: labelBg,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(labels[i],
                          style: AppTextStyles.labelSm.copyWith(
                              fontSize: 13, color: labelColor)),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(q.options[i],
                        style: AppTextStyles.body),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 82,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      color: _cardBg,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: _currentQuestion > 0
                ? () => setState(() {
                      _currentQuestion--;
                      _selectedAnswer = null;
                    })
                : null,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.chevron_left, color: Colors.white, size: 18),
                  SizedBox(width: 4),
                  Text('CÂU TRƯỚC',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_up_rounded,
              color: Colors.white, size: 24),
          GestureDetector(
            onTap: () => setState(() {
              _currentQuestion =
                  (_currentQuestion + 1) % _totalQuestions;
              _selectedAnswer = null;
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Text('CÂU SAU',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, color: Colors.white, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Question {
  final String text;
  final List<String> options;
  final int correctIndex;
  final bool hasImage;
  final String? badge;
  const _Question({
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.hasImage,
    required this.badge,
  });
}
