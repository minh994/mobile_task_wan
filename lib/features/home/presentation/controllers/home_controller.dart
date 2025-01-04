import '../../../../core/di/service_locator.dart';
import '../../services/task_service.dart';
import '../../services/user_service.dart';
import '../../domain/models/task.dart';
import 'package:flutter/foundation.dart';

class HomeController extends ChangeNotifier {
  final _taskService = getIt<TaskService>();
  final _userService = getIt<UserService>();
  
  String get userName {
    final user = _userService.value;
    if (user != null) {
      print('User from service: ${user.name}'); // Debug print
      return user.name.split(' ').first;
    }
    return 'User';
  }

  List<Task> get priorityTasks => _taskService.priorityTasks;
  List<Task> get dailyTasks => _taskService.dailyTasks;
  bool get isLoading => _taskService.isLoading || _userService.isLoading;

  Future<void> loadData(String userId) async {
    try {
      print('Loading data for user ID: $userId'); // Debug print
      await Future.wait([
        _userService.loadUser(userId),
        _taskService.loadTasks(userId),
      ]);
      notifyListeners();
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  Future<void> toggleTaskStatus(String userId, String taskId) async {
    await _taskService.toggleTaskStatus(userId, taskId);
    notifyListeners();
  }

  @override
  void dispose() {
    _taskService.dispose();
    _userService.dispose();
    super.dispose();
  }
} 