import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../core/base/base_controller.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../services/auth_service.dart';
import '../core/routes/app_router.dart';

class CalendarController extends BaseController with GetTickerProviderStateMixin {
  final _taskService = Get.find<TaskService>();
  final _authService = Get.find<AuthService>();
  
  late TabController tabController;
  final selectedDate = DateTime.now().obs;
  final isPrioritySelected = true.obs;
  final tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    loadTasksForDate(selectedDate.value);
    
    // Lắng nghe thay đổi của tasks từ TaskService
    ever(_taskService.tasks, (_) {
      loadTasksForDate(selectedDate.value);
    });

    // Lắng nghe thay đổi tab
    tabController.addListener(() {
      isPrioritySelected.value = tabController.index == 0;
      loadTasksForDate(selectedDate.value);
    });
  }

  Future<void> loadTasksForDate(DateTime date) async {
    try {
      final userId = _authService.currentUser.value?.uid;
      if (userId != null) {
        final allTasks = await _taskService.getTasksByDate(date, userId);
        
        // Lọc tasks theo loại đã chọn
        tasks.value = allTasks.where((task) => 
          isPrioritySelected.value 
            ? task.type == 'Priority Task'
            : task.type == 'Daily Task'
        ).toList();

        // Sắp xếp tasks
        tasks.sort((a, b) => a.isCompleted ? 1 : -1);
        
        // Force UI update
        tasks.refresh();
      }
    } catch (e) {
      print('Error loading tasks: $e');
      showError('Error loading tasks');
    }
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    loadTasksForDate(date);
  }

  void toggleTaskType(bool isPriority) {
    isPrioritySelected.value = isPriority;
    tabController.animateTo(isPriority ? 0 : 1);
    loadTasksForDate(selectedDate.value);
  }

  void goToTaskDetail(Task task) {
    Get.toNamed('/task-detail', arguments: {'task': task})?.then((result) {
      if (result == true) {
        // Reload tasks if task was edited or deleted
        loadTasksForDate(selectedDate.value);
      }
    });
  }

  void addTask() {
    Get.toNamed('/add-task')?.then((result) {
      if (result == true) {
        // Reload tasks if new task was added
        loadTasksForDate(selectedDate.value);
      }
    });
  }

  String formatDate(DateTime date) {
    return DateFormat('MMMM d, y').format(date);
  }

  String formatShortDate(DateTime date) {
    return DateFormat('MMM d').format(date);
  }

  void goToHome() => Get.offAllNamed(AppRouter.home);
  void goToProfile() => Get.offAllNamed(AppRouter.profile);

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
} 