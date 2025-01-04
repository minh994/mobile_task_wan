import 'package:get/get.dart';
import '../../services/auth_service.dart';
import '../../services/task_service.dart';
import '../../services/user_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Khởi tạo UserService trước
    Get.put(UserService(), permanent: true);
    Get.put(AuthService(), permanent: true);
    Get.put(TaskService(), permanent: true);
  }
} 