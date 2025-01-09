import 'dart:io';
import 'package:get/get.dart';
import '../core/base/base_controller.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../core/routes/app_router.dart';
import '../widgets/logout_dialog.dart';

class ProfileController extends BaseController {
  final _authService = Get.find<AuthService>();
  final _userService = Get.find<UserService>();

  final name = ''.obs;
  final occupation = ''.obs;
  final location = ''.obs;
  final photoUrl = ''.obs;
  final tasksCompleted = '0'.obs;
  final email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  String getImageUrl(String? url) {
    if (url == null || url.isEmpty) {
      return ''; // Return empty for default avatar icon
    }
    
    // Kiểm tra nếu là đường dẫn network (Google avatar)
    if (url.startsWith('http')) {
      return url;
    }
    
    // Kiểm tra nếu là đường dẫn local file
    if (url.startsWith('file://')) {
      return url;
    }
    
    // Nếu là đường dẫn local không có file://
    try {
      final file = File(url);
      if (file.existsSync()) {
        return file.path;
      }
    } catch (e) {
      print('Lỗi tải hình ảnh: $e');
    }
    
    return '';
  }

  Future<void> loadUserData() async {
    try {
      showLoading();
      final currentUser = _authService.currentUser.value;
      if (currentUser != null) {
        // Kiểm tra nếu đăng nhập bằng Google
        if (currentUser.providerData.any((info) => 
            info.providerId == 'google.com')) {
          // Lấy thông tin từ Google account
          name.value = currentUser.displayName ?? '';
          photoUrl.value = currentUser.photoURL ?? '';
          email.value = currentUser.email ?? '';
        } else {
          // Đăng nhập bằng email - để avatar mặc định
          name.value = currentUser.email?.split('@')[0] ?? '';
          photoUrl.value = ''; // Empty để hiển thị avatar mặc định
          email.value = currentUser.email ?? '';
        }

        // Load thêm thông tin từ Firestore nếu có
        await _userService.loadUser(currentUser.uid);
        final userData = _userService.currentUser.value;
        if (userData != null) {
          // Chỉ cập nhật các field khác, giữ nguyên name và photo từ Google
          occupation.value = userData.occupation;
          location.value = userData.location;
          tasksCompleted.value = '0'; // TODO: Load từ statistics
        }
      }
      hideLoading();
    } catch (e) {
      hideLoading();
      showError('error_loading_user'.tr + e.toString());
    }
  }

  void editProfile() {
    Get.toNamed('/edit-profile'.tr);
  }

  void goToMyProfile() async {
    try {
      final user = _authService.currentUser.value;
      if (user != null) {
        Get.toNamed(AppRouter.myProfile);
      } else {
        showError('session_expired'.tr);
        Get.offAllNamed(AppRouter.login);
      }
    } catch (e) {
      print('Lỗi khi điều hướng đến Hồ sơ của bạn: $e');
      showError('Có lỗi xảy ra'.tr);
    }
  }

  void goToStatistics() {
    Get.toNamed(AppRouter.statistics);
  }

  void goToLocation() {
    Get.toNamed('/location'.tr);
  }

  void goToSettings() {
    Get.toNamed('/settings'.tr);
  }

  Future<void> logout() async {
    try {
      final result = await Get.dialog<Map<String, dynamic>>(LogoutDialog());
      
      if (result != null && result['logout'] == true) {
        // Lưu trạng thái remember login nếu được chọn
        if (result['remember'] == true) {
          // TODO: Lưu thông tin đăng nhập
        }
        
        await _authService.signOut();
        Get.offAllNamed(AppRouter.login);
      }
    } catch (e) {
      showError('error_logout'.tr + e.toString());
    }
  }

  void goToHome() => Get.offAllNamed(AppRouter.home);
  void goToCalendar() => Get.offAllNamed(AppRouter.calendar);
} 