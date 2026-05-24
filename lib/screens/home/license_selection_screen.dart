import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

class LicenseSelectionScreen extends StatefulWidget {
  const LicenseSelectionScreen({super.key});

  @override
  State<LicenseSelectionScreen> createState() => _LicenseSelectionScreenState();
}

class _LicenseSelectionScreenState extends State<LicenseSelectionScreen> {
  static const Color _cardBg = Color(0xFF2C2C2E);
  static const Color _screenBg = Color(0xFF1C1C1E);

  String _selected = 'B1';

  final List<_LicenseType> _types = const [
    _LicenseType('A1', 'Xe máy dưới 175cc', Color(0xFF30D158)),
    _LicenseType('A2', 'Xe máy trên 175cc', Color(0xFF4A9FD8)),
    _LicenseType('B1', 'Ô tô không kinh doanh', Color(0xFFFFD60A)),
    _LicenseType('B2', 'Ô tô kinh doanh', Color(0xFFFF9F0A)),
    _LicenseType('C', 'Xe tải trên 3.5 tấn', Color(0xFFFF453A)),
    _LicenseType('D', 'Xe khách 10-30 chỗ', Color(0xFFBF5AF2)),
    _LicenseType('E', 'Xe khách trên 30 chỗ', Color(0xFF4A9FD8)),
    _LicenseType('F', 'Xe chuyên dụng', Color(0xFF30D158)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _screenBg,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xxl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Column(
                children: [
                  Text('Chọn loại bằng lái',
                      style: AppTextStyles.display.copyWith(fontSize: 24),
                      textAlign: TextAlign.center),
                  const SizedBox(height: AppSpacing.sm),
                  Text('Chọn loại bằng lái để bắt đầu ôn tập',
                      style: AppTextStyles.body.copyWith(
                          color: const Color(0xFFAEAEB2)),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxxl),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                  childAspectRatio: 1.4,
                  children: _types.map((t) => _buildCard(t)).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppSpacing.r12),
                  ),
                  child: const Center(
                    child: Text('Bắt đầu học',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(_LicenseType t) {
    final selected = t.code == _selected;
    return GestureDetector(
      onTap: () => setState(() => _selected = t.code),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: selected ? AppColors.bgCard : _cardBg,
          borderRadius: BorderRadius.circular(AppSpacing.r16),
          border: selected
              ? Border.all(color: AppColors.primary, width: 2)
              : Border.all(color: Colors.transparent),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(t.code,
                style: AppTextStyles.display.copyWith(
                    fontSize: 32,
                    color: t.color,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.xs),
            Text(t.name,
                style: AppTextStyles.caption.copyWith(
                    color: const Color(0xFFAEAEB2)),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

class _LicenseType {
  final String code;
  final String name;
  final Color color;
  const _LicenseType(this.code, this.name, this.color);
}
