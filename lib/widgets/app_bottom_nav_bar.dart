import 'package:flutter/material.dart';

import '../core/theme/theme.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  static const _tabs = [
    _BottomTab(icon: Icons.menu_book_rounded, label: 'ÔN THI GPLX'),
    _BottomTab(icon: Icons.star_rounded, label: 'ĐÀO TẠO'),
    _BottomTab(icon: Icons.info_rounded, label: 'THÔNG TIN'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      color: AppColors.bgCard,
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final tab = _tabs[index];
          final selected = index == currentIndex;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTabSelected(index),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      selected ? const Color(0xFF3A3A3C) : Colors.transparent,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tab.icon,
                      color: selected
                          ? AppColors.primary
                          : const Color(0xFFAEAEB2),
                      size: 18,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tab.label,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 10,
                        color: selected
                            ? AppColors.primary
                            : const Color(0xFFC7C7CC),
                        fontWeight:
                            selected ? FontWeight.w700 : FontWeight.w400,
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

class _BottomTab {
  const _BottomTab({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}
