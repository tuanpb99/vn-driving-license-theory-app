import 'package:flutter/material.dart';
import '../../core/navigation/app_tab_navigation.dart';
import '../../core/theme/theme.dart';
import '../../data/models/exam_models.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../quiz/quiz_screen.dart';
import 'config_screen.dart';

class ThiThuScreen extends StatefulWidget {
  const ThiThuScreen({super.key});

  @override
  State<ThiThuScreen> createState() => _ThiThuScreenState();
}

class _ThiThuScreenState extends State<ThiThuScreen> {
  static const Color _cardBg = Color(0xFF2C2C2E);
  static const Color _screenBg = Color(0xFF1C1C1E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _screenBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildStatusBar(),
            _buildNavBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                child: Column(
                  children: [
                    _buildFirstRow(),
                    const SizedBox(height: 12),
                    ...List.generate(10, (rowIndex) {
                      final start = rowIndex * 3 + 3;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildExamRow(start, start + 1, start + 2),
                      );
                    }),
                  ],
                ),
              ),
            ),
            AppBottomNavBar(
              currentIndex: 1,
              onTabSelected: (index) =>
                  AppTabNavigation.openTab(context, index, 1),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('23:32',
              style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w600)),
          const Row(children: [
            Icon(Icons.signal_cellular_alt, color: Colors.white, size: 16),
            SizedBox(width: 6),
            Icon(Icons.wifi, color: Colors.white, size: 16),
            SizedBox(width: 6),
            Icon(Icons.battery_full, color: Colors.white, size: 20),
          ]),
        ],
      ),
    );
  }

  Widget _buildNavBar(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.chevron_left,
                color: AppColors.primary, size: 28),
          ),
          const Expanded(
            child: Center(
              child: Text('OTOMOTO - B', style: AppTextStyles.nav),
            ),
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }

  Widget _buildFirstRow() {
    return Row(
      children: [
        Expanded(
          child: _buildRandomCard(),
        ),
        const SizedBox(width: 12),
        Expanded(child: _buildExamCard('Đề 1')),
        const SizedBox(width: 12),
        Expanded(child: _buildExamCard('Đề 2')),
      ],
    );
  }

  Widget _buildRandomCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const QuizScreen.random()),
        );
      },
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shuffle_rounded,
                color: AppColors.accentGreen, size: 32),
            const SizedBox(height: 8),
            Text('Câu hỏi\nngẫu nhiên',
                textAlign: TextAlign.center,
                style: AppTextStyles.label.copyWith(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildExamRow(int a, int b, int c) {
    return Row(
      children: [
        Expanded(child: _buildExamCard('Đề $a')),
        const SizedBox(width: 12),
        Expanded(child: _buildExamCard('Đề $b')),
        const SizedBox(width: 12),
        Expanded(child: _buildExamCard('Đề $c')),
      ],
    );
  }

  Widget _buildExamCard(String label) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ConfigScreen(
              initialConfig: ExamConfigRequest(),
            ),
          ),
        );
      },
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(label, style: AppTextStyles.h2.copyWith(fontSize: 18)),
        ),
      ),
    );
  }
}
