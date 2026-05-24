import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const Color _cardBg = Color(0xFF2C2C2E);
  static const Color _screenBg = Color(0xFF1C1C1E);
  static const Color _subtitleColor = Color(0xFFAEAEB2);
  static const Color _dividerColor = Color(0xFF3A3A3C);

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.sm),
                    _buildProfileSection(),
                    const SizedBox(height: AppSpacing.md),
                    _buildStatsRow(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildSectionLabel('Cài đặt'),
                    const SizedBox(height: AppSpacing.sm),
                    _buildSettingsGroup(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildSectionLabel('Hỗ trợ'),
                    const SizedBox(height: AppSpacing.sm),
                    _buildSupportGroup(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildLogoutButton(),
                    const SizedBox(height: AppSpacing.sm),
                    _buildVersion(),
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
              style: AppTextStyles.bodySm
                  .copyWith(fontWeight: FontWeight.w600)),
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

  Widget _buildNavBar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Thông Tin',
              style: AppTextStyles.h2.copyWith(fontSize: 18)),
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.settings_rounded,
                color: AppColors.primary, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.r16),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(Icons.person_rounded,
                color: Colors.white, size: 28),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('Học Viên GPLX',
              style: AppTextStyles.h2.copyWith(fontSize: 18)),
          const SizedBox(height: 4),
          Text('hocvien@email.com',
              style: AppTextStyles.bodySm
                  .copyWith(color: _subtitleColor)),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.accentOrange,
              borderRadius:
                  BorderRadius.circular(AppSpacing.rFull),
            ),
            child: Text('Tài khoản miễn phí',
                style: AppTextStyles.labelSm
                    .copyWith(fontSize: 11)),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppSpacing.r12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.bolt_rounded,
                    color: Colors.white, size: 16),
                const SizedBox(width: AppSpacing.sm),
                Text('Nâng cấp Pro - 30% OFF',
                    style: AppTextStyles.label
                        .copyWith(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final stats = [
      _Stat('600', 'Câu đã học', AppColors.primary),
      _Stat('32', 'Đề đã thi', AppColors.accentGreen),
      _Stat('87%', 'Tỉ lệ đúng', AppColors.accentYellow),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: stats
            .map((s) => Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        right: s == stats.last ? 0 : AppSpacing.md),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 8),
                    decoration: BoxDecoration(
                      color: _cardBg,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.r16),
                    ),
                    child: Column(
                      children: [
                        Text(s.value,
                            style: AppTextStyles.h2
                                .copyWith(
                                    fontSize: 18, color: s.color)),
                        const SizedBox(height: 4),
                        Text(s.label,
                            style: AppTextStyles.caption
                                .copyWith(color: _subtitleColor)),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Text(label,
          style: AppTextStyles.label
              .copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
    );
  }

  Widget _buildSettingsGroup() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.r16),
      ),
      child: Column(
        children: [
          _buildSettingsRow(
              Icons.notifications_rounded, AppColors.primary,
              'Thông báo'),
          _buildDivider(),
          _buildSettingsRow(
              Icons.dark_mode_rounded, AppColors.accentGreen,
              'Chế độ tối'),
          _buildDivider(),
          _buildSettingsRow(
              Icons.language_rounded, AppColors.accentOrange,
              'Ngôn ngữ'),
        ],
      ),
    );
  }

  Widget _buildSupportGroup() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.r16),
      ),
      child: Column(
        children: [
          _buildSettingsRow(
              Icons.chat_bubble_rounded, const Color(0xFFBF5AF2),
              'Hướng dẫn sử dụng'),
          _buildDivider(),
          _buildSettingsRow(
              Icons.star_rounded, AppColors.accentRed,
              'Đánh giá ứng dụng'),
        ],
      ),
    );
  }

  Widget _buildSettingsRow(
      IconData icon, Color iconBg, String label) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 16),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(label, style: AppTextStyles.bodyLg),
            ),
            Icon(Icons.chevron_right_rounded,
                color: _subtitleColor, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: _dividerColor,
      margin: const EdgeInsets.only(left: AppSpacing.lg),
    );
  }

  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 52,
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.accentRed.withOpacity(0.15),
          borderRadius: BorderRadius.circular(AppSpacing.r12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout_rounded,
                color: AppColors.accentRed, size: 18),
            const SizedBox(width: AppSpacing.sm),
            Text('Đăng xuất',
                style: AppTextStyles.label.copyWith(
                    fontSize: 15, color: AppColors.accentRed)),
          ],
        ),
      ),
    );
  }

  Widget _buildVersion() {
    return Center(
      child: Text('OTOMOTO v2.4.1',
          style: AppTextStyles.caption
              .copyWith(color: const Color(0xFF636366))),
    );
  }

  Widget _buildTabBar() {
    const tabs = [
      _TabItem(icon: Icons.menu_book_rounded, label: 'ÔN THI GPLX'),
      _TabItem(icon: Icons.star_rounded, label: 'ĐÀO TẠO LÁI XE'),
      _TabItem(icon: Icons.info_rounded, label: 'THÔNG TIN'),
    ];
    return Container(
      height: 82,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      color: _cardBg,
      child: Row(
        children: List.generate(tabs.length, (i) {
          final selected = i == 2;
          return Expanded(
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
                  Icon(tabs[i].icon,
                      color: selected
                          ? AppColors.primary
                          : const Color(0xFFAEAEB2),
                      size: 18),
                  const SizedBox(height: 4),
                  Text(tabs[i].label,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 10,
                        color: selected
                            ? AppColors.primary
                            : const Color(0xFFC7C7CC),
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w400,
                      )),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _Stat {
  final String value;
  final String label;
  final Color color;
  const _Stat(this.value, this.label, this.color);
}

class _TabItem {
  final IconData icon;
  final String label;
  const _TabItem({required this.icon, required this.label});
}
