import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/base/base_view.dart';
import '../../controllers/profile_controller.dart';
import '../../core/constants/app_colors.dart';

class ProfileScreen extends BaseView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildProfileInfo(),
            _buildMenuItems(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: controller.editProfile,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Obx(() => CircleAvatar(
                radius: 50,
                backgroundImage: controller.photoUrl.isNotEmpty
                    ? NetworkImage(controller.photoUrl.value)
                    : null,
                child: controller.photoUrl.isEmpty
                    ? const Icon(Icons.person, size: 50)
                    : null,
              )),
          const SizedBox(height: 16),
          Obx(() => Text(
                controller.name.value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
          const SizedBox(height: 8),
          Obx(() => Text(
                controller.occupation.value,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoItem(
            'Location',
            Icons.location_on_outlined,
            controller.location,
          ),
          _buildInfoItem(
            'Tasks Completed',
            Icons.check_circle_outline,
            controller.tasksCompleted,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, IconData icon, RxString value) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Obx(() => Text(
              value.value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            )),
      ],
    );
  }

  Widget _buildMenuItems() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildMenuItem(
            'My Profile',
            Icons.person_outline,
            controller.goToMyProfile,
          ),
          _buildMenuItem(
            'Statistic',
            Icons.bar_chart_outlined,
            controller.goToStatistics,
          ),
          _buildMenuItem(
            'Location',
            Icons.location_on_outlined,
            controller.goToLocation,
          ),
          _buildMenuItem(
            'Settings',
            Icons.settings_outlined,
            controller.goToSettings,
          ),
          _buildMenuItem(
            'Logout',
            Icons.logout,
            controller.logout,
            isLogout: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    IconData icon,
    VoidCallback onTap, {
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : AppColors.primary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.black87,
          fontSize: 16,
        ),
      ),
      trailing: isLogout
          ? null
          : const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
      onTap: onTap,
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home_outlined, false, () => Get.offNamed('/home')),
          _buildNavItem(
              Icons.calendar_today, false, () => Get.offNamed('/calendar')),
          _buildNavItem(Icons.person, true, () {}),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        color: isSelected ? AppColors.primary : Colors.grey,
        size: 28,
      ),
    );
  }
}
