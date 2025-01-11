import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/services/auth_service.dart';
import '../core/base/base_controller.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import 'package:intl/intl.dart';
import '../widgets/calendar_picker.dart';

class AddTaskController extends BaseController {
  final _taskService = Get.find<TaskService>();
  final _authService = Get.find<AuthService>();
  
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final todoController = TextEditingController();
  
  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().add(const Duration(days: 1)).obs;
  final isPriorityTask = true.obs;
  final todoItems = <String>[].obs;

  String get formattedStartDate => 
      DateFormat('MMM d, yyyy').format(startDate.value);
  
  String get formattedEndDate => 
      DateFormat('MMM d, yyyy').format(endDate.value);

  void toggleTaskType(bool isPriority) {
    isPriorityTask.value = isPriority;
    if (!isPriority) {
      endDate.value = startDate.value.add(const Duration(days: 1));
    } else {
      endDate.value = startDate.value.add(const Duration(days: 7));
    }
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
      if (!isPriorityTask.value) {
        endDate.value = date.add(const Duration(days: 1));
      } else if (date.isAfter(endDate.value)) {
        endDate.value = date;
      }
    }
  }

  Future<void> selectEndDate() async {
    if (!isPriorityTask.value) return;

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

  void addTodoItem() {
    if (todoController.text.trim().isNotEmpty) {
      todoItems.add(todoController.text.trim());
      todoController.clear();
    }
  }

  void removeTodoItem(int index) {
    todoItems.removeAt(index);
  }

  Future<void> saveTask() async {
    if (titleController.text.isEmpty) {
      showError('Please enter task title'.tr);
      return;
    }

    try {
      showLoading();
      final userId = _authService.currentUser.value?.uid;
      if (userId != null) {
        final task = Task(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          createdAt: startDate.value,
          dueDate: endDate.value,
          type: isPriorityTask.value ? 'Priority Task'.tr : 'Daily Task'.tr,
          todoItems: todoItems.toList(),
          priority: isPriorityTask.value ? TaskPriority.high : TaskPriority.medium,
          progress: 0.0,
          isCompleted: false,
        );

        await _taskService.addTask(task, userId);
        hideLoading();
        Get.back(result: true);
        showMessage('Task added successfully'.tr);
      }
    } catch (e) {
      hideLoading();
      showError('Error adding task: $e'.tr);
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    todoController.dispose();
    super.onClose();
  }
} 