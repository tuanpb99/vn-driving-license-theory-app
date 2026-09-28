import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

class QuestionListOverlay extends StatefulWidget {
  const QuestionListOverlay({super.key});

  @override
  State<QuestionListOverlay> createState() => _QuestionListOverlayState();
}

class _QuestionListOverlayState extends State<QuestionListOverlay> {
  static const Color _cardBg = Color(0xFF2C2C2E);
  static const Color _optionBg = Color(0xFF3A3A3C);

  final int _total = 30;
  final int _current = 10;
  final Set<int> _answered = {1, 2, 3, 4, 5, 6, 7, 8, 9};
  final Set<int> _flagged = {3, 7};

  Color _boxColor(int n) {
    if (_flagged.contains(n)) return AppColors.accentYellow;
    if (_answered.contains(n)) return AppColors.primary;
    return _optionBg;
  }

  Color _textColor(int n) {
    if (_flagged.contains(n)) return Colors.black;
    if (_answered.contains(n)) return Colors.white;
    return const Color(0xFF8E8E93);
  }

  bool _isCurrent(int n) => n == _current;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        children: [
          const Spacer(),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF2C2C2E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHandle(),
                _buildHeader(context),
                _buildLegend(),
                _buildGrid(),
                _buildSubmitButton(context),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: const Color(0xFF636366),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Danh sách câu hỏi', style: AppTextStyles.h3),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, color: AppColors.primary, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Row(
        children: [
          _buildLegendItem(_optionBg, const Color(0xFF8E8E93), 'Chưa làm'),
          const SizedBox(width: 16),
          _buildLegendItem(AppColors.primary, Colors.white, 'Đã làm'),
          const SizedBox(width: 16),
          _buildLegendItem(AppColors.accentYellow, Colors.black, 'Đánh dấu'),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color bg, Color textColor, String label) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
          child: Center(
            child: Text('1', style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }

  Widget _buildGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate((_total / 5).ceil(), (row) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: List.generate(5, (col) {
                final n = row * 5 + col + 1;
                if (n > _total) return const Expanded(child: SizedBox());
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                          color: _isCurrent(n) ? Colors.transparent : _boxColor(n),
                          borderRadius: BorderRadius.circular(4),
                          border: _isCurrent(n)
                              ? Border.all(color: AppColors.primary, width: 1.5)
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            '$n',
                            style: TextStyle(
                              color: _isCurrent(n) ? AppColors.primary : _textColor(n),
                              fontSize: 12,
                              fontWeight: _isCurrent(n) ? FontWeight.w700 : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppSpacing.r12),
          ),
          child: const Center(
            child: Text('Nộp bài',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}

Future<void> showQuestionListOverlay(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const QuestionListOverlay(),
  );
}
