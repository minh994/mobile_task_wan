import 'package:get/get.dart';
import '../core/base/base_controller.dart';
import '../services/task_service.dart';
import '../services/user_service.dart';

class HomeController extends BaseController {
  final _userService = Get.find<UserService>();
  final _taskService = Get.find<TaskService>();

  @override
  void onInit() {
    super.onInit();
    loadData(_userService.currentUser.value?.id ?? '');
  }

  Future<void> loadData(String userId) async {
    try {
      await Future.wait([
        _userService.loadUser(userId),
        _taskService.loadTasks(userId),
      ]);
    } catch (e) {
      showError('Error loading data: $e');
    }
  }
}
