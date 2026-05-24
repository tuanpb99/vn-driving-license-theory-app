import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

Future<void> showSubmitConfirmDialog(
  BuildContext context, {
  required VoidCallback onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (ctx) => Dialog(
      backgroundColor: const Color(0xFF2C2C2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nộp bài?', style: AppTextStyles.h3),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Bạn còn 5 câu chưa trả lời. Bạn có chắc muốn nộp bài không?',
              style: AppTextStyles.body.copyWith(color: const Color(0xFFC7C7CC)),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A3A3C),
                      borderRadius: BorderRadius.circular(AppSpacing.r12),
                    ),
                    child: const Center(
                      child: Text('Đã làm: 25/30',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A3A3C),
                      borderRadius: BorderRadius.circular(AppSpacing.r12),
                    ),
                    child: const Center(
                      child: Text('Chưa làm: 5',
                          style: TextStyle(
                              color: Color(0xFFAEAEB2),
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(ctx),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A3A3C),
                        borderRadius: BorderRadius.circular(AppSpacing.r12),
                      ),
                      child: const Center(
                        child: Text('Tiếp tục làm',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(ctx);
                      onConfirm();
                    },
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppSpacing.r12),
                      ),
                      child: const Center(
                        child: Text('Nộp bài',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
