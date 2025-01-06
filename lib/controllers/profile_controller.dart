import 'package:get/get.dart';
import '../core/base/base_controller.dart';
import '../services/auth_service.dart';
import '../core/routes/app_router.dart';

class ProfileController extends BaseController {
  final _authService = Get.find<AuthService>();

  final tasksCompleted = '0'.obs;

  void editProfile() {
    Get.toNamed('/edit-profile');
  }

  void goToMyProfile() async {
    try {
      final user = _authService.currentUser.value;
      if (user != null) {
        Get.toNamed(AppRouter.myProfile);
      } else {
        showError('Phiên đăng nhập đã hết hạn');
        Get.offAllNamed(AppRouter.login);
      }
    } catch (e) {
      print('Error navigating to MyProfile: $e');
      showError('Có lỗi xảy ra');
    }
  }

  void goToStatistics() {
    Get.toNamed('/statistics');
  }

  void goToLocation() {
    Get.toNamed('/location');
  }

  void goToSettings() {
    Get.toNamed('/settings');
  }

  Future<void> logout() async {
    try {
      await _authService.signOut();
      Get.offAllNamed('/login');
    } catch (e) {
      showError('Error logging out: $e');
    }
  }

  void goToHome() => Get.offAllNamed(AppRouter.home);
  void goToCalendar() => Get.offAllNamed(AppRouter.calendar);
}
