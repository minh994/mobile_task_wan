import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/base/base_view.dart';
import '../../controllers/settings_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_router.dart';
import '../../core/translations/app_translations.dart';

class SettingsScreen extends BaseView<SettingsController> {
  const SettingsScreen({super.key});

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
                      _buildSettingsList(),
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
            'settings'.tr,
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

  Widget _buildSettingItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsList() {
    return Column(
      children: [
        _buildSettingItem(
          'notification'.tr,
          Icons.notifications_outlined,
          () => Get.toNamed(AppRouter.notification),
        ),
        _buildSettingItem(
          'security'.tr,
          Icons.security_outlined,
          () => Get.toNamed(AppRouter.security),
        ),
        _buildSettingItem(
          'language'.tr,
          Icons.language_outlined,
          () => Get.toNamed(AppRouter.language),
        ),
        _buildSettingItem(
          'help'.tr,
          Icons.help_outline,
          () => Get.toNamed(AppRouter.help),
        ),
        _buildSettingItem(
          'about'.tr,
          Icons.info_outline,
          () => Get.toNamed(AppRouter.about),
        ),
        _buildSettingItem(
          'location'.tr,
          Icons.location_on_outlined,
          () => Get.toNamed(AppRouter.location),
        ),
      ],
    );
  }
} 