import 'package:get/get.dart';
import '../core/base/base_controller.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../core/routes/app_router.dart';

class ProfileController extends BaseController {
  final _authService = Get.find<AuthService>();
  final _userService = Get.find<UserService>();

  final name = ''.obs;
  final occupation = ''.obs;
  final location = ''.obs;
  final photoUrl = ''.obs;
  final tasksCompleted = '0'.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      showLoading();
      final userId = _authService.currentUser.value?.uid;
      if (userId != null) {
        await _userService.loadUser(userId);
        final user = _userService.currentUser.value;
        if (user != null) {
          name.value = user.name;
          occupation.value = user.occupation;
          location.value = user.location;
          photoUrl.value = user.photoUrl;
        }
      }
      hideLoading();
    } catch (e) {
      hideLoading();
      showError('Error loading user data: $e');
    }
  }

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