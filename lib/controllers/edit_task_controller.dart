import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/controllers/task_detail_controller.dart';
import 'package:mobile_app/widgets/calendar_picker.dart';
import '../core/base/base_controller.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../services/auth_service.dart';
import 'package:intl/intl.dart';

class EditTaskController extends BaseController {
  final _taskService = Get.find<TaskService>();
  final _authService = Get.find<AuthService>();
  late final Task originalTask;
  
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final taskType = ''.obs;
  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().obs;

  String get formattedStartDate => 
      DateFormat('MMM d, yyyy').format(startDate.value);
  
  String get formattedEndDate => 
      DateFormat('MMM d, yyyy').format(endDate.value);

  @override
  void onInit() {
    super.onInit();
    originalTask = Get.arguments['task'];
    _initializeData();
  }

  void _initializeData() {
    titleController.text = originalTask.title;
    descriptionController.text = originalTask.description;
    startDate.value = originalTask.createdAt;
    endDate.value = originalTask.dueDate;
    taskType.value = originalTask.type;
  }

  Future<void> selectStartDate() async {
    final date = await Get.dialog<DateTime>(
      Dialog(
        child: CalendarPicker(
          selectedDate: startDate.value,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) => Get.back(result: date),
        ),
      ),
    );

    if (date != null) {
      startDate.value = date;
      if (taskType.value == 'Daily Task') {
        // Daily Task luôn kết thúc sau 1 ngày
        endDate.value = date.add(const Duration(days: 1));
      }
    }
  }

  Future<void> selectEndDate() async {
    // Chỉ cho phép chọn end date với Priority Task
    if (taskType.value == 'Daily Task') return;

    final date = await Get.dialog<DateTime>(
      Dialog(
        child: CalendarPicker(
          selectedDate: endDate.value,
          firstDate: startDate.value,
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) => Get.back(result: date),
        ),
      ),
    );

    if (date != null) {
      endDate.value = date;
    }
  }

  Future<void> saveTask() async {
    if (titleController.text.isEmpty) {
      showError('Please enter task title');
      return;
    }

    try {
      showLoading();
      final userId = _authService.currentUser.value?.uid;
      if (userId != null) {
        final updatedTask = Task(
          id: originalTask.id,
          title: titleController.text,
          description: descriptionController.text,
          createdAt: startDate.value,
          dueDate: endDate.value,
          type: taskType.value,
          todoItems: originalTask.todoItems,
          priority: taskType.value == 'Priority Task' 
              ? TaskPriority.high 
              : TaskPriority.medium,
          progress: originalTask.progress,
          isCompleted: originalTask.isCompleted,
        );

        await _taskService.updateTask(updatedTask, userId);
        hideLoading();

        // Cập nhật task trong TaskDetailController
        final taskDetailController = Get.find<TaskDetailController>();
        taskDetailController.updateTask(updatedTask);

        Get.back(result: true);
        showMessage('Task updated successfully');
      }
    } catch (e) {
      hideLoading();
      showError('Error updating task: $e');
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
} 