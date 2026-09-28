import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

class InstantGradeScreen extends StatelessWidget {
  const InstantGradeScreen({super.key});

  static const Color _cardBg = Color(0xFF2C2C2E);
  static const Color _screenBg = Color(0xFF1C1C1E);
  static const Color _subtitleColor = Color(0xFFC7C7CC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _screenBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    _buildResultCard(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildSignCard(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildExplanationCard(),
                  ],
                ),
              ),
            ),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, color: AppColors.primary, size: 22),
          ),
          Text('Kết quả câu hỏi', style: AppTextStyles.nav),
          const SizedBox(width: 22),
        ],
      ),
    );
  }

  Widget _buildResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.r16),
        border: Border.all(color: AppColors.accentRed.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.accentRed.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close_rounded,
                color: AppColors.accentRed, size: 36),
          ),
          const SizedBox(height: AppSpacing.md),
          Text('Trả lời sai',
              style: AppTextStyles.h2.copyWith(color: AppColors.accentRed)),
          const SizedBox(height: AppSpacing.sm),
          Text('Đây là câu hỏi điểm liệt 🔥',
              style: AppTextStyles.body.copyWith(color: _subtitleColor)),
          const SizedBox(height: AppSpacing.lg),
          Container(height: 1, color: const Color(0xFF3A3A3C)),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat('Câu của bạn', 'Sai', AppColors.accentRed),
              Container(width: 1, height: 40, color: const Color(0xFF3A3A3C)),
              _buildStat('Đáp án đúng', 'Câu 4', AppColors.accentGreen),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(value,
            style: AppTextStyles.h2.copyWith(fontSize: 20, color: color)),
        const SizedBox(height: 4),
        Text(label,
            style: AppTextStyles.caption.copyWith(color: _subtitleColor)),
      ],
    );
  }

  Widget _buildSignCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Biển báo liên quan',
              style: AppTextStyles.label.copyWith(
                  fontSize: 13,
                  color: _subtitleColor,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.accentRed,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text('!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900)),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Biển báo nguy hiểm',
                        style: AppTextStyles.label),
                    const SizedBox(height: 4),
                    Text('Cảnh báo nguy hiểm phía trước',
                        style: AppTextStyles.caption
                            .copyWith(color: _subtitleColor)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: Color(0xFFAEAEB2), size: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Giải thích',
              style: AppTextStyles.label.copyWith(
                  fontSize: 13,
                  color: _subtitleColor,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Theo quy định của Luật Giao thông đường bộ, người lái xe phải tuân thủ hiệu lệnh của biển báo và đảm bảo an toàn cho bản thân và người tham gia giao thông khác.',
            style: AppTextStyles.body.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      color: _cardBg,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF3A3A3C),
                  borderRadius: BorderRadius.circular(AppSpacing.r12),
                ),
                child: const Center(
                  child: Text('Câu trước',
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
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppSpacing.r12),
                ),
                child: const Center(
                  child: Text('Câu tiếp',
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
    );
  }
}
