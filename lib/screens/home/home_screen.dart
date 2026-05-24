import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';
import '../exam/thi_thu_screen.dart';
import '../road_signs/road_signs_screen.dart';
import '../saved/saved_questions_screen.dart';
import '../settings/settings_screen.dart';
import 'license_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  static const Color _cardBg = Color(0xFF2C2C2E);
  static const Color _screenBg = Color(0xFF1C1C1E);
  static const Color _subtitleColor = Color(0xFFC7C7CC);

  final List<_QuickItem> _quickItems = const [
    _QuickItem(icon: Icons.timer_rounded, label: 'THI THỬ', color: Color(0xFF4A9FD8)),
    _QuickItem(icon: Icons.bookmark_rounded, label: 'ĐÃ LƯU', color: Color(0xFF30D158)),
    _QuickItem(icon: Icons.close_rounded, label: 'CÂU SAI', color: Color(0xFFFF453A)),
    _QuickItem(icon: Icons.star_rounded, label: 'CÂU KHÓ', color: Color(0xFFFFD60A)),
    _QuickItem(icon: Icons.route_rounded, label: 'SA HÌNH', color: Color(0xFF4A9FD8)),
    _QuickItem(icon: Icons.lightbulb_rounded, label: 'MẸO', color: Color(0xFF30D158)),
    _QuickItem(icon: Icons.signpost_rounded, label: 'BIỂN BÁO', color: Color(0xFFFF453A)),
    _QuickItem(icon: Icons.question_answer_rounded, label: 'HỎI ĐÁP', color: Color(0xFF3A3A3C)),
  ];

  final List<_TopicItem> _topics = const [
    _TopicItem(emoji: '🔥', title: 'Câu hỏi điểm liệt', count: '60 câu hỏi', progress: 0.17, color: Color(0xFFFF453A)),
    _TopicItem(emoji: '🎯', title: 'Khái niệm và quy tắc', count: '180 câu hỏi', progress: 0.33, color: Color(0xFF4A9FD8)),
    _TopicItem(emoji: '👤', title: 'Văn hoá và đạo đức', count: '25 câu hỏi', progress: 0.11, color: Color(0xFF30D158)),
    _TopicItem(emoji: '🚗', title: 'Kỹ thuật lái xe', count: '58 câu hỏi', progress: 0.22, color: Color(0xFFFF9F0A)),
    _TopicItem(emoji: '🔧', title: 'Cấu tạo và sửa chữa', count: '37 câu hỏi', progress: 0.14, color: Color(0xFFBF5AF2)),
    _TopicItem(emoji: '⚠️', title: 'Biển báo đường bộ', count: '185 câu hỏi', progress: 0.36, color: Color(0xFFFFD60A)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _screenBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildStatusBar(),
            _buildNavBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.sm),
                    _buildProBanner(),
                    const SizedBox(height: AppSpacing.sm),
                    _buildMenuCard(),
                    const SizedBox(height: AppSpacing.sm),
                    _buildProgressCard(),
                    const SizedBox(height: AppSpacing.sm),
                    _buildAdBanner(),
                    const SizedBox(height: AppSpacing.sm),
                    _buildSectionHeader('Ôn tập theo chủ đề'),
                    const SizedBox(height: AppSpacing.sm),
                    _buildTopicCard(_topics[0]),
                    const SizedBox(height: AppSpacing.sm),
                    _buildSectionHeader('HỌC TẬP THEO CHỦ ĐỀ'),
                    const SizedBox(height: AppSpacing.sm),
                    ..._topics.map((t) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: _buildTopicCard(t),
                        )),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),
            _buildTabBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('23:32',
              style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w600)),
          const Row(
            children: [
              Icon(Icons.signal_cellular_alt, color: Colors.white, size: 16),
              SizedBox(width: 6),
              Icon(Icons.wifi, color: Colors.white, size: 16),
              SizedBox(width: 6),
              Icon(Icons.battery_full, color: Colors.white, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavBar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SettingsScreen())),
            child: Text('Cài đặt',
                style: AppTextStyles.bodyLg.copyWith(color: AppColors.primary)),
          ),
          const Text('OTOMOTO - B', style: AppTextStyles.nav),
          GestureDetector(
            onTap: () {},
            child: Text('Tìm kiếm',
                style: AppTextStyles.bodyLg.copyWith(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  Widget _buildProBanner() {
    return Container(
      height: 72,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(AppSpacing.r12),
      ),
      child: Row(
        children: [
          const Icon(Icons.emoji_events_rounded,
              color: AppColors.accentYellow, size: 32),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Text('Phiên bản Pro',
                        style: AppTextStyles.label),
                    const SizedBox(width: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B00),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('50%',
                          style: AppTextStyles.labelSm
                              .copyWith(fontSize: 10)),
                    ),
                  ],
                ),
                Text('Loại bỏ quảng cáo, hỗ trợ OTOMOTO',
                    style: AppTextStyles.caption
                        .copyWith(color: _subtitleColor)),
              ],
            ),
          ),
          Container(
            height: 52,
            padding:
                const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppSpacing.r12),
            ),
            alignment: Alignment.center,
            child: Text('Nâng cấp',
                style: AppTextStyles.label
                    .copyWith(fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard() {
    final rows = [_quickItems.sublist(0, 4), _quickItems.sublist(4, 8)];
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.lg),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.r16),
      ),
      child: Column(
        children: rows
            .map((row) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: row.map((item) => _buildQuickItem(item)).toList(),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildQuickItem(_QuickItem item) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onQuickItemTap(item.label),
        child: Column(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: item.color,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Icon(item.icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 6),
            Text(item.label,
                style: AppTextStyles.labelSm
                    .copyWith(fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  void _onQuickItemTap(String label) {
    switch (label) {
      case 'THI THỬ':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ThiThuScreen()));
        break;
      case 'ĐÃ LƯU':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SavedQuestionsScreen()));
        break;
      case 'BIỂN BÁO':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const RoadSignsScreen()));
        break;
      default:
        break;
    }
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.lg),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.r16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tiến độ ôn tập',
                  style: AppTextStyles.label
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w700)),
              Row(
                children: [
                  Text('Chỉ số an toàn',
                      style: AppTextStyles.caption
                          .copyWith(color: _subtitleColor)),
                  const SizedBox(width: 4),
                  Text('?',
                      style: AppTextStyles.caption
                          .copyWith(color: _subtitleColor)),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 0.46,
              minHeight: 8,
              backgroundColor: Color(0xFF3A3A3C),
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('600 câu / 32 đề thi',
                  style: AppTextStyles.caption
                      .copyWith(color: _subtitleColor)),
              Text('...',
                  style: AppTextStyles.bodyLg.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdBanner() {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(AppSpacing.r12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Học tiếng Anh miễn phí',
                    style: AppTextStyles.label
                        .copyWith(fontWeight: FontWeight.w700)),
                Text('Tải app ngay hôm nay!',
                    style: AppTextStyles.caption
                        .copyWith(color: _subtitleColor)),
              ],
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppSpacing.r12),
            ),
            child: const Icon(Icons.language_rounded,
                color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(title,
          style: AppTextStyles.label.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _subtitleColor)),
    );
  }

  Widget _buildTopicCard(_TopicItem topic) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(topic.emoji,
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(width: AppSpacing.sm),
              Text(topic.title,
                  style: AppTextStyles.label.copyWith(
                      fontSize: 15, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: topic.progress,
              minHeight: 6,
              backgroundColor: const Color(0xFF3A3A3C),
              valueColor: AlwaysStoppedAnimation<Color>(topic.color),
            ),
          ),
          const SizedBox(height: 6),
          Text(topic.count,
              style: AppTextStyles.caption
                  .copyWith(color: _subtitleColor)),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    const tabs = [
      _TabItem(icon: Icons.menu_book_rounded, label: 'ÔN THI GPLX'),
      _TabItem(icon: Icons.star_rounded, label: 'ĐÀO TẠO'),
      _TabItem(icon: Icons.info_rounded, label: 'THÔNG TIN'),
    ];

    return Container(
      height: 82,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      color: _cardBg,
      child: Row(
        children: List.generate(tabs.length, (i) {
          final selected = i == _selectedTab;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedTab = i);
                if (i == 1) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ThiThuScreen()));
                } else if (i == 2) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.bgCard
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tabs[i].icon,
                      color: selected
                          ? AppColors.primary
                          : const Color(0xFFAEAEB2),
                      size: 18,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tabs[i].label,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 10,
                        color: selected
                            ? AppColors.primary
                            : const Color(0xFFC7C7CC),
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _QuickItem {
  final IconData icon;
  final String label;
  final Color color;
  const _QuickItem(
      {required this.icon, required this.label, required this.color});
}

class _TopicItem {
  final String emoji;
  final String title;
  final String count;
  final double progress;
  final Color color;
  const _TopicItem(
      {required this.emoji,
      required this.title,
      required this.count,
      required this.progress,
      required this.color});
}

class _TabItem {
  final IconData icon;
  final String label;
  const _TabItem({required this.icon, required this.label});
}
