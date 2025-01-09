import 'package:get/get.dart';
import '../../controllers/security_controller.dart';

class SecurityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecurityController>(() => SecurityController());
  }
} 