import 'package:get/get.dart';
import 'package:mobile_app/services/auth_service.dart';
import '../core/base/base_controller.dart';

class RegisterController extends BaseController {
  final AuthService _authService = Get.find<AuthService>();

  final username = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> register() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      showError('Please enter all information'.tr);
      return;
    }

    if (password.value != confirmPassword.value) {
      showError('Password does not match'.tr);
      return;
    }

    await handleError(() async {
      final UserCredential = await _authService.createUserWithEmailAndPassword(
        email.value,
        password.value,
      );
      if (UserCredential != null) {
        Get.offNamed('/verify-email', arguments: {'email': email.value});
      } else {
        showError('User not found'.tr);
      }
    });
  }

  void goToLogin() {
    Get.back();
  }

  Future<void> registerWithGoogle() async {
    await handleError(() async {
      await _authService.signInWithGoogle();
      Get.offAllNamed('/home');
    });
  }
}
