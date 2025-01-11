import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/base/base_controller.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../services/auth_service.dart';
import '../controllers/home_controller.dart';

class TaskDetailController extends BaseController {
  final _taskService = Get.find<TaskService>();
  final _authService = Get.find<AuthService>();
  late final Rx<Task> task;

  @override
  void onInit() {
    super.onInit();
    task = Rx<Task>(Get.arguments['task']);
  }

  void updateTask(Task updatedTask) {
    task.value = updatedTask;
  }

  void editTask() async {
    final result = await Get.toNamed('/edit-task', arguments: {'task': task.value});
    if (result == true) {
      // Refresh home screen tasks after edit
      Get.find<HomeController>().refreshTasks();
    }
  }

  Future<void> deleteTask() async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: Text('Delete Task'.tr),
        content: Text('Are you sure you want to delete this task?'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('Cancel'.tr),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text('Delete'.tr),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        showLoading();
        final userId = _authService.currentUser.value?.uid;
        if (userId != null) {
          await _taskService.deleteTask(task.value.id, userId);
          hideLoading();
          
          // Refresh home screen tasks
          Get.find<HomeController>().refreshTasks();
          
          // Return to previous screen
          Get.back(result: true);
          showMessage('Task deleted successfully'.tr);
        }
      } catch (e) {
        hideLoading();
        showError('Error deleting task: $e'.tr);
      }
    }
  }
} 