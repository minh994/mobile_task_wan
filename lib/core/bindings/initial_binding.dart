import 'package:get/get.dart';
import '../../services/auth_service.dart';
import '../../services/task_service.dart';
import '../../services/user_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize services in correct order
    Get.put<UserService>(UserService(), permanent: true);
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put<TaskService>(TaskService(), permanent: true);
  }
} 