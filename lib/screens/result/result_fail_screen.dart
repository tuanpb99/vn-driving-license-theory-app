import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

class ResultFailScreen extends StatefulWidget {
  const ResultFailScreen({super.key});

  @override
  State<ResultFailScreen> createState() => _ResultFailScreenState();
}

class _ResultFailScreenState extends State<ResultFailScreen> {
  static const Color _cardBg = Color(0xFF2C2C2E);
  static const Color _screenBg = Color(0xFF1C1C1E);
  static const Color _subtitleColor = Color(0xFFC7C7CC);
  int _selectedTab = 0;

  final List<_ResultQuestion> _questions = const [
    _ResultQuestion(num: 1, text: 'Tốc độ tối đa cho phép xe ô tô con đi trên đường cao tốc là bao nhiêu?', correctAnswer: 'A. 120 km/h', userAnswer: 'A. 120 km/h', isCorrect: true),
    _ResultQuestion(num: 2, text: 'Khi gặp biển báo "Đường ưu tiên", người lái xe phải làm gì?', correctAnswer: 'B. Được quyền đi trước', userAnswer: 'C. Nhường đường', isCorrect: false),
    _ResultQuestion(num: 3, text: 'Câu hỏi điểm liệt: Nồng độ cồn tối đa cho phép khi lái xe là bao nhiêu?', correctAnswer: 'A. 0 mg/100ml máu', userAnswer: 'C. 50 mg/100ml máu', isCorrect: false),
  ];

  List<_ResultQuestion> get _filtered {
    if (_selectedTab == 1) return _questions.where((q) => q.isCorrect).toList();
    if (_selectedTab == 2) return _questions.where((q) => !q.isCorrect).toList();
    return _questions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _screenBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    _buildHeroCard(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildProgressSection(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildFilterTabs(),
                    const SizedBox(height: AppSpacing.md),
                    ..._filtered.map((q) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: _buildQuestionCard(q),
                        )),
                  ],
                ),
              ),
            ),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
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
          Text('Kết quả', style: AppTextStyles.nav),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text('Thi lại',
                style: AppTextStyles.bodyLg.copyWith(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.r16),
      ),
      child: Column(
        children: [
          Text('RỚT',
              style: AppTextStyles.display.copyWith(
                  color: AppColors.accentRed, fontSize: 32)),
          const SizedBox(height: AppSpacing.sm),
          Text('Sai câu điểm liệt 🔥',
              style: AppTextStyles.body.copyWith(color: _subtitleColor)),
          const SizedBox(height: AppSpacing.lg),
          Container(height: 1, color: const Color(0xFF3A3A3C)),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat('Điểm số', '24/30', AppColors.primary),
              Container(width: 1, height: 40, color: const Color(0xFF3A3A3C)),
              _buildStat('Đúng', '24', AppColors.accentGreen),
              Container(width: 1, height: 40, color: const Color(0xFF3A3A3C)),
              _buildStat('Sai', '6', AppColors.accentRed),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.h2.copyWith(color: color)),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.caption.copyWith(color: _subtitleColor)),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Kết quả chi tiết',
              style: AppTextStyles.label.copyWith(fontSize: 15, fontWeight: FontWeight.w700)),
          const SizedBox(height: AppSpacing.lg),
          _buildProgressRow('Câu đúng', 0.80, AppColors.accentGreen, '80%'),
          const SizedBox(height: AppSpacing.md),
          _buildProgressRow('Câu sai', 0.20, AppColors.accentRed, '20%'),
        ],
      ),
    );
  }

  Widget _buildProgressRow(String label, double value, Color color, String pct) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.label.copyWith(color: const Color(0xFFAEAEB2))),
            Text(pct, style: AppTextStyles.label.copyWith(color: color)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 8,
            backgroundColor: const Color(0xFF3A3A3C),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTabs() {
    const tabs = ['Tất cả', 'Câu đúng', 'Câu sai'];
    return Row(
      children: List.generate(tabs.length, (i) {
        final selected = i == _selectedTab;
        return Padding(
          padding: EdgeInsets.only(right: i < tabs.length - 1 ? 8 : 0),
          child: GestureDetector(
            onTap: () => setState(() => _selectedTab = i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : const Color(0xFF3A3A3C),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(tabs[i],
                  style: AppTextStyles.body.copyWith(
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400)),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildQuestionCard(_ResultQuestion q) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.r12),
        border: q.isCorrect ? null : Border.all(color: AppColors.accentRed.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A3A52),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text('Câu ${q.num}',
                    style: AppTextStyles.labelSm.copyWith(color: AppColors.primary, fontSize: 12)),
              ),
              Icon(q.isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: q.isCorrect ? AppColors.accentGreen : AppColors.accentRed, size: 18),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(q.text, style: AppTextStyles.body),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: AppColors.accentGreen, size: 16),
              const SizedBox(width: 6),
              Text(q.correctAnswer,
                  style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.accentGreen)),
            ],
          ),
          if (!q.isCorrect) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.cancel_rounded, color: AppColors.accentRed, size: 16),
                const SizedBox(width: 6),
                Text('Bạn chọn: ${q.userAnswer}',
                    style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.accentRed)),
              ],
            ),
          ],
          const SizedBox(height: 4),
          Text('Xem giải thích',
              style: AppTextStyles.caption.copyWith(color: const Color(0xFFAEAEB2))),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      color: _cardBg,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.accentRed,
            borderRadius: BorderRadius.circular(AppSpacing.r12),
          ),
          child: const Center(
            child: Text('Thi lại ngay',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}

class _ResultQuestion {
  final int num;
  final String text;
  final String correctAnswer;
  final String userAnswer;
  final bool isCorrect;
  const _ResultQuestion({
    required this.num, required this.text, required this.correctAnswer,
    required this.userAnswer, required this.isCorrect,
  });
}
