// Tạo mới file này để xử lý navigation chung
import 'package:get/get.dart';

class BaseNavigationController extends GetxController {
  void goToHome() {
    Get.offAllNamed('/home');
  }

  void goToCalendar() {
    Get.offAllNamed('/calendar');
  }

  void goToProfile() {
    Get.offAllNamed('/profile');
  }
} 