import 'package:flutter/material.dart';
import '../../core/base/base_view.dart';
import '../../controllers/register_controller.dart';
import 'package:get/get.dart';
import 'widgets/register_form.dart';

class RegisterScreen extends BaseView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                const RegisterForm(),
                const SizedBox(height: 16),
                _buildLoginLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/laravel_icon.png',
          height: 100,
        ),
        const SizedBox(height: 16),
        const Text(
          'Tạo tài khoản mới',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Đã có tài khoản?'),
        TextButton(
          onPressed: controller.goToLogin,
          child: const Text('Đăng nhập'),
        ),
      ],
    );
  }
}
