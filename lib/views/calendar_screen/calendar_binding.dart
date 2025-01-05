import 'package:get/get.dart';
import '../../controllers/calendar_controller.dart';
import '../../services/task_service.dart';
import '../../services/auth_service.dart';

class CalendarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskService>(() => TaskService());
    Get.lazyPut<AuthService>(() => AuthService());
    Get.put<CalendarController>(CalendarController());
  }
}
