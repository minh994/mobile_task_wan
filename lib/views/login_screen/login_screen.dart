import 'package:flutter/material.dart';
import 'package:mobile_app/core/routes/app_router.dart';
import '../../core/base/base_view.dart';
import '../../controllers/login_controller.dart';
import 'package:get/get.dart';
import 'widgets/social_login_button.dart';

class LoginScreen extends BaseView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildForm(),
                const SizedBox(height: 24),
                _buildSocialLogin(),
                const SizedBox(height: 16),
                _buildRegisterLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      children: [
        Text(
          'TASK-WAN',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0066FF),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Management App',
          style: TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 14,
          ),
        ),
        SizedBox(height: 40),
        // Login text
        Text(
          'Login to your account',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildEmailField(),
        const SizedBox(height: 16),
        _buildPasswordField(),
        const SizedBox(height: 8),
        _buildForgotPassword(),
        const SizedBox(height: 24),
        _buildLoginButton(),
        const SizedBox(height: 16),
        _buildDivider(),
      ],
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: controller.passwordTEC,
      obscureText: !controller.isPasswordVisible.value,
      decoration: InputDecoration(
        prefixIcon: Container(
          padding: const EdgeInsets.all(12),
          child: const Icon(Icons.lock_outline, color: Colors.grey),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            controller.isPasswordVisible.value
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            controller.togglePasswordVisibility();
          },
        ),
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: controller.emailTEC,
      decoration: InputDecoration(
        prefixIcon: Container(
          padding: const EdgeInsets.all(12),
          child: const Icon(Icons.email_outlined, color: Colors.grey),
        ),
        hintText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: controller.goToForgotPassword,
      child: const Text('Forgot Password?'),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: controller.login,
      child: const Text('Login'),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 1,
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 12,
          ),
        ),
        GestureDetector(
          onTap: () => Get.toNamed(AppRouter.register),
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Color(0xFF0066FF),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          'assets/google.png',
          controller.loginWithGoogle,
        ),
        const SizedBox(width: 32),
        _buildSocialButton(
          'assets/facebook.png',
          () {},
        ),
        const SizedBox(width: 32),
        _buildSocialButton(
          'assets/twitter.png',
          () {},
        ),
      ],
    );
  }

  Widget _buildSocialButton(String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          imagePath,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
