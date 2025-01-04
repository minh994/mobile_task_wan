import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobile_app/services/auth_service.dart';
import '../core/base/base_controller.dart';

class LoginController extends BaseController {
  final AuthService _authService = Get.find<AuthService>();

  final emailTEC = TextEditingController();
  final passwordTEC = TextEditingController();

  final email = ''.obs;
  final password = ''.obs;
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      showError('Vui lòng nhập đầy đủ thông tin');
      return;
    }

    await handleError(() async {
      await _authService.signInWithEmailAndPassword(
        email.value,
        password.value,
      );
      Get.offAllNamed('/home');
    });
  }

  Future<void> loginWithGoogle() async {
    await handleError(() async {
      await _authService.signInWithGoogle();
      Get.offAllNamed('/home');
    });
  }

  void goToRegister() {
    Get.toNamed('/register');
  }

  void goToForgotPassword() {
    Get.toNamed('/forgot-password');
  }
}
