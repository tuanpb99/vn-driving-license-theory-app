import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/quiz_controller.dart';
import '../../core/theme/theme.dart';
import '../../data/models/exam_models.dart';
import '../../data/models/question_model.dart';
import '../../data/repositories/question_repository.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({
    super.key,
    this.config = const ExamConfigRequest(),
  }) : isRandom = false;

  const QuizScreen.random({super.key})
      : config = null,
        isRandom = true;

  final ExamConfigRequest? config;
  final bool isRandom;

  static const Color _cardBg = Color(0xFF2C2C2E);
  static const Color _screenBg = Color(0xFF1C1C1E);
  static const Color _optionBg = Color(0xFF2C2C2E);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final controller = QuizController(context.read<QuestionRepository>());
        if (isRandom) {
          controller.loadRandomQuestions();
        } else {
          controller.loadExam(config ?? const ExamConfigRequest());
        }
        return controller;
      },
      child: Consumer<QuizController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return _buildStateScaffold(
              child: const CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (controller.errorMessage != null ||
              controller.currentQuestion == null) {
            return _buildStateScaffold(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_off_rounded,
                      color: AppColors.accentRed, size: 40),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    controller.errorMessage ?? 'Không có câu hỏi nào',
                    style: AppTextStyles.bodyLg,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  GestureDetector(
                    onTap: () {
                      if (isRandom) {
                        controller.loadRandomQuestions();
                      } else {
                        controller
                            .loadExam(config ?? const ExamConfigRequest());
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppSpacing.r12),
                      ),
                      child: const Text(
                        'THỬ LẠI',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          final question = controller.currentQuestion!;
          return Scaffold(
            backgroundColor: _screenBg,
            body: SafeArea(
              child: Column(
                children: [
                  _buildTopBar(context),
                  _buildQuestionGrid(controller),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildQuestionHeader(controller),
                          _buildQuestionCard(question),
                          const SizedBox(height: AppSpacing.sm),
                          _buildAnswers(controller, question),
                        ],
                      ),
                    ),
                  ),
                  _buildBottomNav(controller),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStateScaffold({required Widget child}) {
    return Scaffold(
      backgroundColor: _screenBg,
      body: SafeArea(
        child: Center(child: child),
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
          Row(
            children: [
              _buildTimerBar(),
              const SizedBox(width: AppSpacing.md),
              Text('20:00',
                  style: AppTextStyles.nav.copyWith(color: AppColors.primary)),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Text('Nộp bài',
                style: AppTextStyles.bodyLg.copyWith(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerBar() {
    return SizedBox(
      width: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: const LinearProgressIndicator(
          value: 0.6,
          minHeight: 6,
          backgroundColor: Color(0xFF3A3A3C),
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildQuestionGrid(QuizController controller) {
    final rows = <Widget>[];
    for (var start = 1; start <= controller.totalQuestions; start += 15) {
      final end = (start + 14).clamp(1, controller.totalQuestions);
      rows.add(_buildGridRow(controller, start, end));
      if (end < controller.totalQuestions) {
        rows.add(const SizedBox(height: 4));
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      color: _cardBg,
      child: Column(children: rows),
    );
  }

  Widget _buildGridRow(QuizController controller, int start, int end) {
    return Row(
      children: List.generate(end - start + 1, (i) {
        final number = start + i;
        final isCurrent = number == controller.currentIndex + 1;
        return Expanded(
          child: GestureDetector(
            onTap: () => controller.selectQuestion(number - 1),
            child: Container(
              height: 22,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: isCurrent
                    ? Border.all(color: AppColors.primary, width: 1.5)
                    : null,
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 11,
                    color:
                        isCurrent ? AppColors.primary : const Color(0xFFAEAEB2),
                    fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildQuestionHeader(QuizController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Câu ${controller.currentIndex + 1}',
              style:
                  AppTextStyles.body.copyWith(color: const Color(0xFFAEAEB2))),
          const Icon(Icons.bookmark_border_rounded,
              color: Color(0xFFAEAEB2), size: 20),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(QuestionModel question) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (question.isCritical) ...[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius: BorderRadius.circular(AppSpacing.rFull),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: AppColors.accentRed, size: 14),
                  const SizedBox(width: 4),
                  Text('Điểm liệt',
                      style: AppTextStyles.labelSm.copyWith(
                        color: AppColors.accentRed,
                        fontSize: 12,
                      )),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          Text(question.question,
              style:
                  AppTextStyles.bodyLg.copyWith(fontWeight: FontWeight.w500)),
          if (question.hasImage) ...[
            const SizedBox(height: AppSpacing.lg),
            _buildQuestionImage(question),
          ],
        ],
      ),
    );
  }

  Widget _buildQuestionImage(QuestionModel question) {
    final source = question.hinhanhq!;
    if (source.startsWith('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.r12),
        child: Image.network(
          source,
          height: 150,
          width: double.infinity,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => _buildImagePlaceholder(question),
        ),
      );
    }
    return _buildImagePlaceholder(question);
  }

  Widget _buildImagePlaceholder(QuestionModel question) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3C),
        borderRadius: BorderRadius.circular(AppSpacing.r12),
      ),
      child: Center(
        child: Text(
          question.hinhanhqAlt ?? 'Hình minh họa',
          textAlign: TextAlign.center,
          style: AppTextStyles.caption.copyWith(color: const Color(0xFFAEAEB2)),
        ),
      ),
    );
  }

  Widget _buildAnswers(QuizController controller, QuestionModel question) {
    const labels = ['A', 'B', 'C', 'D', 'E'];
    final selectedAnswer = controller.selectedAnswer;
    final correctIndex = question.correctIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        children: List.generate(question.answers.length, (i) {
          final isSelected = selectedAnswer == i;
          final isCorrect = selectedAnswer != null && i == correctIndex;
          final isWrong = isSelected && i != correctIndex;

          Color borderColor = Colors.transparent;
          Color bgColor = _optionBg;
          Color labelBg = const Color(0xFF3A3A3C);
          Color labelColor = const Color(0xFFAEAEB2);

          if (isCorrect) {
            borderColor = AppColors.accentGreen;
            bgColor = AppColors.accentGreen.withOpacity(0.1);
            labelBg = AppColors.accentGreen.withOpacity(0.2);
            labelColor = AppColors.accentGreen;
          } else if (isWrong) {
            borderColor = AppColors.accentRed;
            bgColor = AppColors.accentRed.withOpacity(0.1);
            labelBg = AppColors.accentRed.withOpacity(0.2);
            labelColor = AppColors.accentRed;
          } else if (isSelected) {
            borderColor = AppColors.primary;
            labelBg = AppColors.bgCard;
            labelColor = AppColors.primary;
          }

          return GestureDetector(
            onTap: () => controller.selectAnswer(i),
            child: Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm + 2),
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(AppSpacing.r12),
                border: Border.all(color: borderColor, width: 2),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: labelBg,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(labels[i],
                          style: AppTextStyles.labelSm.copyWith(
                            fontSize: 13,
                            color: labelColor,
                          )),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(question.answers[i].text,
                        style: AppTextStyles.body),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBottomNav(QuizController controller) {
    return Container(
      height: 82,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      color: _cardBg,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: controller.currentIndex > 0
                ? controller.previousQuestion
                : null,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: controller.currentIndex > 0
                    ? AppColors.primary
                    : const Color(0xFF3A3A3C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.chevron_left, color: Colors.white, size: 18),
                  SizedBox(width: 4),
                  Text('CÂU TRƯỚC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      )),
                ],
              ),
            ),
          ),
          Text(
            '${controller.currentIndex + 1}/${controller.totalQuestions}',
            style: AppTextStyles.label.copyWith(color: Colors.white),
          ),
          GestureDetector(
            onTap: controller.nextQuestion,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Text('CÂU SAU',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      )),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, color: Colors.white, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
