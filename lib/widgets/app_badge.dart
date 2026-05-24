import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

enum AppBadgeVariant { primary, success, danger, warning, orange }

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.primary,
  });

  final String label;
  final AppBadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final bg = Color.lerp(color, AppColors.bgPrimary, 0.8)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppSpacing.rFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpacing.sm - 2),
          Text(label, style: AppTextStyles.labelSm.copyWith(color: color)),
        ],
      ),
    );
  }

  Color _getColor() {
    switch (variant) {
      case AppBadgeVariant.primary:
        return AppColors.primary;
      case AppBadgeVariant.success:
        return AppColors.accentGreen;
      case AppBadgeVariant.danger:
        return AppColors.accentRed;
      case AppBadgeVariant.warning:
        return AppColors.accentYellow;
      case AppBadgeVariant.orange:
        return AppColors.accentOrange;
    }
  }
}
