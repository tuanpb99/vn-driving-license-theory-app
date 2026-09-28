import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/exam_config_controller.dart';
import '../../core/theme/theme.dart';
import '../../data/models/exam_models.dart';
import '../quiz/quiz_screen.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({
    super.key,
    this.initialConfig = const ExamConfigRequest(),
  });

  final ExamConfigRequest initialConfig;

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  static const Color _cardBg = Color(0xFF2C2C2E);
  static const Color _screenBg = Color(0xFF1C1C1E);
  static const Color _divider = Color(0xFF3A3A3C);
  static const Color _subtitleColor = Color(0xFFC7C7CC);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final controller = ExamConfigController();
        controller.setTotalQuestions(widget.initialConfig.totalQuestions);
        controller.setCriticalQuestions(widget.initialConfig.criticalQuestions);
        controller
            .setQuestionsWithImages(widget.initialConfig.questionsWithImages);
        return controller;
      },
      child: Consumer<ExamConfigController>(
        builder: (context, controller, _) {
          return Scaffold(
            backgroundColor: _screenBg,
            body: SafeArea(
              child: Column(
                children: [
                  _buildHeader(context),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionLabel('THÔNG TIN BÀI THI'),
                          _buildInfoCard(controller),
                          _buildSectionLabel('CHẾ ĐỘ CHẤM ĐIỂM BÀI THI'),
                          _buildScoringCard(controller),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                            child: Text(
                              '• Ứng dụng sẽ chấm điểm và hiển thị kết quả sau khi bạn nộp bài thi.\n• Chế độ này tương tự khi thi sát hạch và phù hợp để luyện tập thi thử.',
                              style: AppTextStyles.caption
                                  .copyWith(color: _subtitleColor),
                            ),
                          ),
                          _buildSectionLabel('TÙY CHỈNH'),
                          _buildToggleCard(controller),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                  _buildStartButton(context, controller),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, color: AppColors.primary, size: 22),
          ),
          Text('Thi thử lý thuyết - hạng B',
              style: AppTextStyles.h2.copyWith(fontSize: 18)),
          const SizedBox(width: 22),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
      child: Text(label,
          style: AppTextStyles.label
              .copyWith(fontSize: 13, color: const Color(0xFFC7C7CC))),
    );
  }

  Widget _buildInfoCard(ExamConfigController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          _buildInfoRow('Số lượng câu hỏi', '${controller.totalQuestions} câu'),
          _buildDivider(),
          _buildInfoRow('Điểm đạt tối thiểu', '27/30 câu'),
          _buildDivider(),
          _buildInfoRow('Thời gian làm bài', '20 phút'),
          _buildDivider(),
          const SizedBox(height: 4),
          Text(
            'Câu hỏi điểm liệt: Học viên trả lời sai câu hỏi này sẽ bị trượt bài thi.',
            style: AppTextStyles.bodySm.copyWith(color: _subtitleColor),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodyLg),
        Text(value,
            style: AppTextStyles.label
                .copyWith(fontSize: 15, color: AppColors.primary)),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(height: 1, color: _divider),
    );
  }

  Widget _buildScoringCard(ExamConfigController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Chấm điểm sau khi nộp bài',
                  style: AppTextStyles.bodyLg),
              if (controller.scoreAfterSubmit)
                const Icon(Icons.check, color: AppColors.primary, size: 20),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(height: 1, color: _divider),
          ),
          GestureDetector(
            onTap: () => controller.setScoreAfterSubmit(false),
            child: const Row(
              children: [
                Text('Chấm điểm nhanh khi chọn đáp án',
                    style: AppTextStyles.bodyLg),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleCard(ExamConfigController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Tự động chuyển câu', style: AppTextStyles.bodyLg),
          Switch(
            value: controller.autoNext,
            onChanged: controller.setAutoNext,
            activeColor: AppColors.primary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFF636366),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton(
    BuildContext context,
    ExamConfigController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuizScreen(config: controller.request),
                ),
              );
            },
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('BẮT ĐẦU LÀM BÀI',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Container(
              width: 134,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
