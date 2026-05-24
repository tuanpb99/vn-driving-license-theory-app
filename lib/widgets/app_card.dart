import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    this.title,
    this.subtitle,
    this.body,
    this.onTap,
    this.child,
    this.padding,
  });

  final String? title;
  final String? subtitle;
  final String? body;
  final VoidCallback? onTap;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(AppSpacing.r12),
          border: Border.all(color: AppColors.borderDefault),
        ),
        child: child ??
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(title!, style: AppTextStyles.h3),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(subtitle!, style: AppTextStyles.caption),
                ],
                if (body != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(body!, style: AppTextStyles.bodySm.copyWith(color: AppColors.textSecondary)),
                ],
              ],
            ),
      ),
    );
  }
}
