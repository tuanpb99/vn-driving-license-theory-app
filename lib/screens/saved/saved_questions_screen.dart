import 'package:flutter/material.dart';
import '../../core/navigation/app_tab_navigation.dart';
import '../../core/theme/theme.dart';
import '../../widgets/app_bottom_nav_bar.dart';

class SavedQuestionsScreen extends StatefulWidget {
  const SavedQuestionsScreen({super.key});

  @override
  State<SavedQuestionsScreen> createState() => _SavedQuestionsScreenState();
}

class _SavedQuestionsScreenState extends State<SavedQuestionsScreen> {
  static const Color _cardBg = Color(0xFF2C2C2E);
  static const Color _screenBg = Color(0xFF1C1C1E);
  int _selectedFilter = 0;

  final List<_SavedQuestion> _questions = const [
    _SavedQuestion(
      badge: 'Tốc độ',
      question:
          'Tốc độ tối đa cho phép xe ô tô con đi trên đường cao tốc là bao nhiêu?',
      answer: 'A. 120 km/h',
    ),
    _SavedQuestion(
      badge: 'Biển báo',
      question: 'Khi gặp biển báo "Đường ưu tiên", người lái xe phải làm gì?',
      answer: 'B. Được quyền đi trước',
    ),
    _SavedQuestion(
      badge: 'Luật',
      question: 'Nồng độ cồn tối đa cho phép khi lái xe là bao nhiêu?',
      answer: 'A. 0 mg/100ml máu',
    ),
    _SavedQuestion(
      badge: 'Kỹ thuật',
      question:
          'Xe ô tô khi đi trên đường phải bật đèn chiếu sáng trong trường hợp nào?',
      answer: 'C. Từ 19h đến 5h sáng',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _screenBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildStatusBar(),
            _buildHeader(context),
            const SizedBox(height: 8),
            _buildSummaryBar(),
            const SizedBox(height: 4),
            _buildFilterRow(),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                itemCount: _questions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _buildQuestionCard(_questions[i]),
              ),
            ),
            AppBottomNavBar(
              currentIndex: 0,
              onTabSelected: (index) =>
                  AppTabNavigation.openTab(context, index, 0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: _screenBg,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('23:32',
              style:
                  AppTextStyles.bodySm.copyWith(fontWeight: FontWeight.w600)),
          const Row(children: [
            Icon(Icons.signal_cellular_alt, color: Colors.white, size: 16),
            SizedBox(width: 6),
            Icon(Icons.wifi, color: Colors.white, size: 16),
          ]),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: _screenBg,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child:
                const Icon(Icons.chevron_left, color: Colors.white, size: 24),
          ),
          Text('Câu Đã Lưu', style: AppTextStyles.h2.copyWith(fontSize: 18)),
          const Icon(Icons.delete_outline_rounded,
              color: AppColors.accentRed, size: 24),
        ],
      ),
    );
  }

  Widget _buildSummaryBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('48 câu đã lưu',
                style: AppTextStyles.label
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text('Ôn tập ngay',
                  style: AppTextStyles.label.copyWith(fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterRow() {
    const filters = ['Tất cả', 'Chưa thuộc', 'Đã thuộc'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: List.generate(filters.length, (i) {
          final selected = i == _selectedFilter;
          return Padding(
            padding: EdgeInsets.only(right: i < filters.length - 1 ? 8 : 0),
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilter = i),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : const Color(0xFF3A3A3C),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(filters[i],
                    style: AppTextStyles.body.copyWith(
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    )),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildQuestionCard(_SavedQuestion q) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A3A52),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(q.badge,
                    style: AppTextStyles.labelSm
                        .copyWith(color: AppColors.primary, fontSize: 12)),
              ),
              const Icon(Icons.bookmark_rounded,
                  color: AppColors.primary, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Text(q.question, style: AppTextStyles.body),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.check_circle_rounded,
                  color: AppColors.accentGreen, size: 16),
              const SizedBox(width: 6),
              Text(q.answer,
                  style: AppTextStyles.label
                      .copyWith(fontSize: 14, color: AppColors.accentGreen)),
            ],
          ),
          const SizedBox(height: 4),
          Text('Xem giải thích',
              style: AppTextStyles.caption
                  .copyWith(color: const Color(0xFFAEAEB2))),
        ],
      ),
    );
  }
}

class _SavedQuestion {
  final String badge;
  final String question;
  final String answer;
  const _SavedQuestion(
      {required this.badge, required this.question, required this.answer});
}
