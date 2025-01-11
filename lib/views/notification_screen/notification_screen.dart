import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/base/base_view.dart';
import '../../controllers/notification_controller.dart';
import '../../core/constants/app_colors.dart';

class NotificationScreen extends BaseView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNotificationTone(),
                      const SizedBox(height: 20),
                      _buildVibrate(),
                      const SizedBox(height: 20),
                      _buildPopupNotification(),
                      const SizedBox(height: 20),
                      _buildHighPriorityNotification(),
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
            'notification'.tr,
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

  Widget _buildNotificationTone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notification Tone'.tr,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => Text(
          controller.notificationTone.value,
          style: const TextStyle(
            fontSize: 16,
          ),
        )),
      ],
    );
  }

  Widget _buildVibrate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vibrate'.tr,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => Text(
          controller.vibrate.value ? 'On'.tr : 'Off'.tr,
          style: const TextStyle(
            fontSize: 16,
          ),
        )),
      ],
    );
  }

  Widget _buildPopupNotification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pop up Notification'.tr,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => Text(
          controller.popupNotification.value ? 'On'.tr : 'Off'.tr,
          style: const TextStyle(
            fontSize: 16,
          ),
        )),
      ],
    );
  }

  Widget _buildHighPriorityNotification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Use High Priority Notification'.tr,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              'Show previews of notification on the top\nof the screen'.tr,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            Obx(() => Switch(
              value: controller.highPriorityNotification.value,
              onChanged: controller.toggleHighPriorityNotification,
              activeColor: AppColors.primary,
            )),
          ],
        ),
      ],
    );
  }
} 