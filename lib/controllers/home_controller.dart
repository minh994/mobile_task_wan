import 'package:get/get.dart';
import 'package:mobile_app/core/base/base_controller.dart';

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
      print('Loading data for user ID: $userId'); // Debug print
      await Future.wait([
        _userService.loadUser(userId),
        _taskService.loadTasks(userId),
      ]);
    } catch (e) {
      print('Error loading data: $e');
    }
  }
}
