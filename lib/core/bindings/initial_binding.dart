import 'package:get/get.dart';
import '../../services/auth_service.dart';
import '../../services/task_service.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/calendar_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../controllers/my_profile_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put<TaskService>(TaskService(), permanent: true);

    // Pre-init controllers
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<CalendarController>(() => CalendarController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<MyProfileController>(() => MyProfileController(), fenix: true);
  }
}
