import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

Future<void> showSignDetailModal(
  BuildContext context, {
  required String name,
  required String description,
  Color shapeColor = AppColors.accentRed,
  String? meaning,
  String? warning,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _SignDetailSheet(
      name: name,
      description: description,
      shapeColor: shapeColor,
      meaning: meaning ?? 'Biển báo này có ý nghĩa cảnh báo người tham gia giao thông cần chú ý và tuân thủ quy định.',
      warning: warning ?? 'Vi phạm quy định này có thể bị xử phạt theo Nghị định 100/2019/NĐ-CP.',
    ),
  );
}

class _SignDetailSheet extends StatelessWidget {
  const _SignDetailSheet({
    required this.name,
    required this.description,
    required this.shapeColor,
    required this.meaning,
    required this.warning,
  });

  final String name;
  final String description;
  final Color shapeColor;
  final String meaning;
  final String warning;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2C2C2E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40, height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF636366),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Chi tiết biển báo', style: AppTextStyles.h3),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: AppColors.primary, size: 22),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Container(
            width: 80, height: 80,
            decoration: BoxDecoration(color: shapeColor, shape: BoxShape.circle),
            child: const Center(
              child: Text('!', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900)),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(name, style: AppTextStyles.h2.copyWith(fontSize: 20), textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.sm),
          Text(description,
              style: AppTextStyles.body.copyWith(color: const Color(0xFFC7C7CC)),
              textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.xl),
          _buildSection('Ý NGHĨA', meaning),
          const SizedBox(height: AppSpacing.lg),
          _buildSection('LƯU Ý', warning),
          const SizedBox(height: AppSpacing.xl),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppSpacing.r12),
              ),
              child: const Center(
                child: Text('Đã hiểu',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: AppTextStyles.labelSm.copyWith(
                color: const Color(0xFFAEAEB2),
                fontSize: 12,
                letterSpacing: 1.2)),
        const SizedBox(height: AppSpacing.sm),
        Text(content,
            style: AppTextStyles.body.copyWith(color: const Color(0xFFC7C7CC), height: 1.6)),
      ],
    );
  }
}
