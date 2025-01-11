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

  @override
  void onInit() {
    super.onInit();
    // Lắng nghe sự thay đổi của TextEditingController
    emailTEC.addListener(() => email.value = emailTEC.text);
    passwordTEC.addListener(() => password.value = passwordTEC.text);
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      showError('Please enter all information'.tr);
      return;
    }

    try {
      showLoading();
      final userCredential = await _authService.signInWithEmailAndPassword(
        email.value,
        password.value,
      );

      // Kiểm tra xác thực email
      if (userCredential?.user != null && !userCredential!.user!.emailVerified) {
        hideLoading();
        Get.offNamed('/verify-email', arguments: {'email': email.value});
        return;
      }

      hideLoading();
      Get.offAllNamed('/home');
    } catch (e) {
      hideLoading();
      showError(e.toString());
    }
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

  @override
  void onClose() {
    emailTEC.dispose();
    passwordTEC.dispose();
    super.onClose();
  }
}
