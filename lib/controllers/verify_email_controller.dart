import 'dart:async';
import 'package:get/get.dart';
import '../core/base/base_controller.dart';
import '../services/auth_service.dart';

class VerifyEmailController extends BaseController {
  final AuthService _authService = Get.find<AuthService>();
  final email = ''.obs;
  final isEmailVerified = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    email.value = Get.arguments['email'] ?? '';
    // Kiểm tra trạng thái xác thực mỗi 3 giây
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => checkEmailVerification(),
    );
  }

  Future<void> checkEmailVerification() async {
    try {
      final verified = await _authService.checkEmailVerified();
      if (verified) {
        _timer?.cancel();
        isEmailVerified.value = true;
        Get.offAllNamed('/verify-success');
      }
    } catch (e) {
      showError('Không thể kiểm tra trạng thái xác thực');
    }
  }

  Future<void> resendVerificationEmail() async {
    await handleError(() async {
      await _authService.resendVerificationEmail();
      showMessage('Đã gửi lại email xác thực');
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
} 