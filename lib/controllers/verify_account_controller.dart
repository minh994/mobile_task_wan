import 'package:get/get.dart';
import '../core/base/base_controller.dart';

class VerifyAccountController extends BaseController {
  final email = ''.obs;
  final canResend = true.obs;
  final resendCountdown = 0.obs;

  @override
  void onInit() {
    super.onInit();
    email.value = Get.arguments['email'] ?? '';
  }

  Future<void> resendVerificationEmail() async {
    // Implementation
  }

  Future<void> checkEmailVerification() async {
    // Implementation
  }
}
