import 'package:flutter/material.dart';
import '../../core/navigation/app_tab_navigation.dart';
import '../../core/theme/theme.dart';
import '../../widgets/app_bottom_nav_bar.dart';

class RoadSignsScreen extends StatefulWidget {
  const RoadSignsScreen({super.key});

  @override
  State<RoadSignsScreen> createState() => _RoadSignsScreenState();
}

class _RoadSignsScreenState extends State<RoadSignsScreen> {
  static const Color _cardBg = Color(0xFF2C2C2E);
  static const Color _screenBg = Color(0xFF1C1C1E);
  int _selectedFilter = 0;

  final List<String> _filters = [
    'Tất cả',
    'Cấm',
    'Nguy hiểm',
    'Hiệu lệnh',
    'Chỉ dẫn'
  ];

  final List<_SignCard> _signs = const [
    _SignCard(
        name: 'Cấm đi ngược chiều',
        desc: 'Cấm tất cả các loại xe',
        shapeColor: Color(0xFFFF453A),
        shapeType: 'circle',
        badgeColor: Color(0x33FF453A),
        badgeText: 'Cấm'),
    _SignCard(
        name: 'Đường giao nhau',
        desc: 'Giao lộ phía trước',
        shapeColor: Color(0xFFFF453A),
        shapeType: 'triangle',
        badgeColor: Color(0x33FF453A),
        badgeText: 'Nguy hiểm'),
    _SignCard(
        name: 'Đi thẳng',
        desc: 'Bắt buộc đi thẳng',
        shapeColor: Color(0xFF4A9FD8),
        shapeType: 'circle',
        badgeColor: Color(0x334A9FD8),
        badgeText: 'Hiệu lệnh'),
    _SignCard(
        name: 'Đường ưu tiên',
        desc: 'Xe được quyền ưu tiên',
        shapeColor: Color(0xFFFFD60A),
        shapeType: 'diamond',
        badgeColor: Color(0x33FFD60A),
        badgeText: 'Ưu tiên'),
    _SignCard(
        name: 'STOP',
        desc: 'Dừng lại nhường đường',
        shapeColor: Color(0xFFFF453A),
        shapeType: 'octagon',
        badgeColor: Color(0x33FF453A),
        badgeText: 'Cấm'),
    _SignCard(
        name: 'Bệnh viện',
        desc: 'Có bệnh viện phía trước',
        shapeColor: Color(0xFF4A9FD8),
        shapeType: 'rect',
        badgeColor: Color(0x334A9FD8),
        badgeText: 'Chỉ dẫn'),
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
            _buildFilterRow(),
            _buildStatsRow(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  children: List.generate((_signs.length / 2).ceil(), (i) {
                    final a = i * 2;
                    final b = a + 1;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(child: _buildSignCard(_signs[a])),
                          const SizedBox(width: 10),
                          b < _signs.length
                              ? Expanded(child: _buildSignCard(_signs[b]))
                              : const Expanded(child: SizedBox()),
                        ],
                      ),
                    );
                  }),
                ),
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
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          Text('Biển Báo Giao Thông', style: AppTextStyles.nav),
          const Icon(Icons.search, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Container(
      height: 52,
      color: _screenBg,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 4),
        itemBuilder: (_, i) {
          final selected = i == _selectedFilter;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : const Color(0xFF3A3A3C),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(_filters[i],
                  style: AppTextStyles.bodySm.copyWith(
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  )),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          _buildStatCard('423', 'Biển báo', AppColors.primary),
          const SizedBox(width: 10),
          _buildStatCard('8', 'Nhóm', AppColors.accentGreen),
          const SizedBox(width: 10),
          _buildStatCard('Học hết', 'Tiến độ', AppColors.accentYellow),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(value,
                style: AppTextStyles.h2.copyWith(fontSize: 18, color: color)),
            const SizedBox(height: 4),
            Text(label,
                style: AppTextStyles.caption
                    .copyWith(color: const Color(0xFFAEAEB2))),
          ],
        ),
      ),
    );
  }

  Widget _buildSignCard(_SignCard sign) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShape(sign),
          const SizedBox(height: 6),
          Text(sign.name,
              style: AppTextStyles.labelSm
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(sign.desc,
              style: AppTextStyles.caption
                  .copyWith(color: const Color(0xFFAEAEB2), fontSize: 11)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: sign.badgeColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(sign.badgeText,
                style: AppTextStyles.caption.copyWith(
                    color: sign.shapeColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildShape(_SignCard sign) {
    if (sign.shapeType == 'circle') {
      return Container(
        width: 48,
        height: 48,
        decoration:
            BoxDecoration(color: sign.shapeColor, shape: BoxShape.circle),
      );
    } else if (sign.shapeType == 'triangle') {
      return CustomPaint(
        size: const Size(48, 48),
        painter: _TrianglePainter(sign.shapeColor),
      );
    } else if (sign.shapeType == 'diamond') {
      return Transform.rotate(
        angle: 0.785,
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: sign.shapeColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );
    } else if (sign.shapeType == 'octagon') {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: sign.shapeColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text('STOP',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w900)),
        ),
      );
    } else {
      return Container(
        width: 48,
        height: 36,
        decoration: BoxDecoration(
          color: sign.shapeColor,
          borderRadius: BorderRadius.circular(6),
        ),
      );
    }
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  const _TrianglePainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TrianglePainter old) => old.color != color;
}

class _SignCard {
  final String name;
  final String desc;
  final Color shapeColor;
  final String shapeType;
  final Color badgeColor;
  final String badgeText;
  const _SignCard({
    required this.name,
    required this.desc,
    required this.shapeColor,
    required this.shapeType,
    required this.badgeColor,
    required this.badgeText,
  });
}
