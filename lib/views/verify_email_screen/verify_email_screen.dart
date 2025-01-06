import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/base/base_view.dart';
import '../../controllers/verify_email_controller.dart';
import '../../core/constants/app_colors.dart';

class VerifyEmailScreen extends BaseView<VerifyEmailController> {
  const VerifyEmailScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildBackButton(),
              const SizedBox(height: 40),
              _buildHeader(),
              const SizedBox(height: 40),
              _buildVerificationImage(),
              const SizedBox(height: 40),
              _buildVerificationMessage(),
              const Spacer(),
              _buildResendButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          'TASK-WAN',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Management App',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'Xác thực tài khoản',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationImage() {
    return Image.asset(
      'assets/verification.png',
      height: 200,
    );
  }

  Widget _buildVerificationMessage() {
    return Column(
      children: [
        Text(
          'Chúng tôi đã gửi email xác thực đến',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          controller.email.value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Vui lòng kiểm tra email và nhấp vào liên kết để xác thực tài khoản của bạn',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildResendButton() {
    return TextButton(
      onPressed: controller.resendVerificationEmail,
      child: const Text(
        'Gửi lại email xác thực',
        style: TextStyle(
          fontSize: 16,
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
} 