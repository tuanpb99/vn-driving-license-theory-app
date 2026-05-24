import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

class AppInput extends StatefulWidget {
  const AppInput({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.controller,
    this.prefixIcon,
    this.onChanged,
    this.obscureText = false,
  });

  final String? label;
  final String? hint;
  final String? errorText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final ValueChanged<String>? onChanged;
  final bool obscureText;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool _focused = false;

  Color get _borderColor {
    if (widget.errorText != null) return AppColors.accentRed;
    if (_focused) return AppColors.primary;
    return AppColors.borderDefault;
  }

  Color get _labelColor {
    if (widget.errorText != null) return AppColors.accentRed;
    if (_focused) return AppColors.primary;
    return AppColors.textSecondary;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: AppTextStyles.label.copyWith(color: _labelColor)),
          const SizedBox(height: AppSpacing.sm - 2),
        ],
        Focus(
          onFocusChange: (v) => setState(() => _focused = v),
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(AppSpacing.r12),
              border: Border.all(
                color: _borderColor,
                width: _focused || widget.errorText != null ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                if (widget.prefixIcon != null) ...[
                  const SizedBox(width: AppSpacing.lg),
                  Icon(
                    widget.prefixIcon,
                    size: 18,
                    color: _focused ? AppColors.primary : AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    onChanged: widget.onChanged,
                    obscureText: widget.obscureText,
                    style: AppTextStyles.body,
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: AppTextStyles.body.copyWith(color: AppColors.textMuted),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: widget.prefixIcon != null ? 0 : AppSpacing.lg,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            widget.errorText!,
            style: AppTextStyles.caption.copyWith(color: AppColors.accentRed),
          ),
        ],
      ],
    );
  }
}
