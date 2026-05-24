import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

class AppProgressBar extends StatelessWidget {
  const AppProgressBar({
    super.key,
    required this.value,
    this.label,
    this.valueLabel,
    this.color = AppColors.primary,
  });

  final double value;
  final String? label;
  final String? valueLabel;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || valueLabel != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(label!, style: AppTextStyles.label.copyWith(color: AppColors.textSecondary)),
              if (valueLabel != null)
                Text(valueLabel!, style: AppTextStyles.label.copyWith(color: color)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm - 2),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.rFull),
          child: LinearProgressIndicator(
            value: value.clamp(0.0, 1.0),
            minHeight: 8,
            backgroundColor: AppColors.bgSurface,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
