import 'package:get/get.dart';
import '../models/task.dart';
import '../core/base/base_controller.dart';
import '../services/task_service.dart';
import '../services/auth_service.dart';
import '../core/routes/app_router.dart';

class HomeController extends BaseController {
  final _taskService = Get.find<TaskService>();
  final _authService = Get.find<AuthService>();
  
  final priorityTasks = <Task>[].obs;
  final dailyTasks = <Task>[].obs;
  final userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
    // Lắng nghe thay đổi của tasks
    ever(_taskService.tasks, (_) {
      filterTasks();
    });
  }

  Future<void> loadTasks() async {
    try {
      showLoading();
      final userId = _authService.currentUser.value?.uid;
      if (userId != null) {
        await _taskService.loadTasks(userId);
        filterTasks();
      }
      hideLoading();
    } catch (e) {
      hideLoading();
      showError('Error loading tasks: $e');
    }
  }

  void filterTasks() {
    priorityTasks.value = _taskService.tasks
        .where((task) => task.type == 'Priority Task')
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    dailyTasks.value = _taskService.tasks
        .where((task) => task.type == 'Daily Task')
        .toList()
      ..sort((a, b) => a.isCompleted ? 1 : -1);
      
    priorityTasks.refresh();
    dailyTasks.refresh();
  }

  Future<void> refreshTasks() async {
    await loadTasks();
  }

  void toggleTaskCompletion(Task task) async {
    try {
      final userId = _authService.currentUser.value?.uid;
      if (userId != null) {
        final updatedTask = task.copyWith(
          isCompleted: !task.isCompleted,
        );
        await _taskService.updateTask(updatedTask, userId);
        await loadTasks();
      }
    } catch (e) {
      showError('Error updating task: $e');
    }
  }

  void goToCalendar() => Get.offAllNamed(AppRouter.calendar);
  void goToAddTask() => Get.toNamed('/add-task');
  void goToProfile() => Get.offAllNamed(AppRouter.profile);
}
