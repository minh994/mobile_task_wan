import 'package:get/get.dart';
import '../../controllers/my_profile_controller.dart';

class MyProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyProfileController>(() => MyProfileController());
  }
} 