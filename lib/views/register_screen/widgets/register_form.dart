import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/register_controller.dart';

class RegisterForm extends GetView<RegisterController> {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildEmailField(),
        const SizedBox(height: 16),
        _buildPasswordField(),
        const SizedBox(height: 16),
        _buildConfirmPasswordField(),
        const SizedBox(height: 24),
        _buildRegisterButton(),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextField(
      onChanged: (value) => controller.email.value = value,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Obx(() {
      return TextField(
        onChanged: (value) => controller.password.value = value,
        obscureText: !controller.isPasswordVisible.value,
        decoration: InputDecoration(
          labelText: 'Mật khẩu',
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              controller.isPasswordVisible.value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
            onPressed: controller.togglePasswordVisibility,
          ),
          border: const OutlineInputBorder(),
        ),
      );
    });
  }

  Widget _buildConfirmPasswordField() {
    return Obx(() {
      return TextField(
        onChanged: (value) => controller.confirmPassword.value = value,
        obscureText: !controller.isConfirmPasswordVisible.value,
        decoration: InputDecoration(
          labelText: 'Xác nhận mật khẩu',
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(
              controller.isConfirmPasswordVisible.value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
            onPressed: controller.toggleConfirmPasswordVisibility,
          ),
          border: const OutlineInputBorder(),
        ),
      );
    });
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: controller.register,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const Text(
        'ĐĂNG KÝ',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
