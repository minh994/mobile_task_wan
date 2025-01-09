import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/base/base_view.dart';
import '../../controllers/statistic_controller.dart';
import '../../core/constants/app_colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StatisticScreen extends BaseView<StatisticController> {
  const StatisticScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildYearSelector(),
            _buildStatisticCards(),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildMonthlyProgress(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          Text(
            'statistics'.tr,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYearSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.white),
            onPressed: controller.previousYear,
          ),
          Obx(() => Text(
                controller.selectedYear.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: Colors.white),
            onPressed: controller.nextYear,
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticCards() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'total_tasks'.tr,
              controller.totalTasks.toString(),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildStatCard(
              'completed_tasks'.tr,
              controller.completedTasks.toString(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyProgress() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: List.generate(
        12,
        (index) => _buildMonthProgress(index + 1),
      ),
    );
  }

  Widget _buildMonthProgress(int month) {
    return SizedBox(
      width: (Get.width - 60) / 2,
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: 45,
            lineWidth: 8.0,
            percent: controller.getMonthProgress(month),
            center: Text(
              '${(controller.getMonthProgress(month) * 100).toInt()}%',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            progressColor: AppColors.primary,
            backgroundColor: Colors.grey[200]!,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          const SizedBox(height: 8),
          Text(
            'monthly_progress'.tr,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 