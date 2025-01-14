import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/base/base_view.dart';
import '../../controllers/login_controller.dart';
import '../../core/constants/app_colors.dart';

class LoginScreen extends BaseView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              _buildHeader(),
              const SizedBox(height: 40),
              _buildEmailField(),
              const SizedBox(height: 16),
              _buildPasswordField(),
              _buildForgotPassword(),
              const SizedBox(height: 24),
              _buildLoginButton(),
              const SizedBox(height: 32),
              _buildSocialLogin(),
              const SizedBox(height: 32),
              _buildSignUpLink(),
            ],
          ),
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
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Đăng nhập vào tài khoản của bạn',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller.emailTEC,
        onChanged: (value) => controller.email.value = value,
        decoration: const InputDecoration(
          hintText: 'Email',
          prefixIcon: Icon(
            Icons.email_outlined,
            color: AppColors.primary,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: controller.passwordTEC,
          onChanged: (value) => controller.password.value = value,
          obscureText: !controller.isPasswordVisible.value,
          decoration: InputDecoration(
            hintText: 'Mật khẩu',
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: AppColors.primary,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: controller.togglePasswordVisibility,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      );
    });
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: controller.goToForgotPassword,
        child: Text(
          'Quên mật khẩu?',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: controller.login,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Đăng nhập',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        Text(
          'Hoặc đăng nhập với',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              'assets/google.png',
              controller.loginWithGoogle,
            ),
            const SizedBox(width: 24),
            _buildSocialButton(
              'assets/facebook.png',
              () {},
            ),
            const SizedBox(width: 24),
            _buildSocialButton(
              'assets/twitter.png',
              () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(String asset, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Image.asset(asset),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Không có tài khoản? ',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: controller.goToRegister,
          child: const Text(
            'Đăng ký',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
