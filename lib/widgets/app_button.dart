import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

enum AppButtonVariant { primary, secondary, danger, ghost, success, disabled, small }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isFullWidth = false,
    this.leading,
    this.trailing,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isFullWidth;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final config = _getConfig();
    final height = variant == AppButtonVariant.small ? 36.0 : 52.0;
    final fontSize = variant == AppButtonVariant.small ? 14.0 : 16.0;
    final hPad = variant == AppButtonVariant.small ? AppSpacing.lg : AppSpacing.xxl;
    final vPad = variant == AppButtonVariant.small ? AppSpacing.sm : 14.0;

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: AppSpacing.sm)],
        Text(
          label,
          style: AppTextStyles.button.copyWith(
            fontSize: fontSize,
            color: config.textColor,
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: AppSpacing.sm), trailing!],
      ],
    );

    Widget button = GestureDetector(
      onTap: variant == AppButtonVariant.disabled ? null : onPressed,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
        decoration: BoxDecoration(
          color: config.bgColor,
          borderRadius: BorderRadius.circular(
            variant == AppButtonVariant.small ? AppSpacing.r8 : AppSpacing.r12,
          ),
          border: config.border,
        ),
        child: content,
      ),
    );

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  _ButtonConfig _getConfig() {
    switch (variant) {
      case AppButtonVariant.primary:
        return _ButtonConfig(bgColor: AppColors.primary, textColor: AppColors.textPrimary);
      case AppButtonVariant.secondary:
        return _ButtonConfig(
          bgColor: AppColors.bgCard,
          textColor: AppColors.primary,
          border: Border.all(color: AppColors.borderStrong),
        );
      case AppButtonVariant.danger:
        return _ButtonConfig(bgColor: AppColors.accentRed, textColor: AppColors.textPrimary);
      case AppButtonVariant.ghost:
        return _ButtonConfig(
          bgColor: Colors.transparent,
          textColor: AppColors.primary,
          border: Border.all(color: AppColors.primary),
        );
      case AppButtonVariant.success:
        return _ButtonConfig(bgColor: AppColors.accentGreen, textColor: AppColors.textPrimary);
      case AppButtonVariant.disabled:
        return _ButtonConfig(bgColor: AppColors.bgCard, textColor: AppColors.textSecondary);
      case AppButtonVariant.small:
        return _ButtonConfig(bgColor: AppColors.primary, textColor: AppColors.textPrimary);
    }
  }
}

class _ButtonConfig {
  final Color bgColor;
  final Color textColor;
  final Border? border;
  const _ButtonConfig({required this.bgColor, required this.textColor, this.border});
}
