import 'package:flutter/foundation.dart';
import '../domain/models/task.dart';
import '../data/repositories/task_repository.dart';

class TaskService extends ValueNotifier<List<Task>> {
  final TaskRepository _taskRepository;
  bool _isLoading = false;
  String? _error;

  TaskService(this._taskRepository) : super([]);

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Task> get priorityTasks => value.where((task) => 
    task.priority != TaskPriority.low && !task.isCompleted
  ).toList();
  List<Task> get dailyTasks => value.where((task) => 
    task.type == 'daily'
  ).toList();

  Future<void> loadTasks(String userId) async {
    try {
      _setLoading(true);
      _taskRepository.getTasks(userId).listen((tasks) {
        value = tasks;
        _error = null;
      });
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> toggleTaskStatus(String userId, String taskId) async {
    try {
      _setLoading(true);
      final task = value.firstWhere((t) => t.id == taskId);
      await _taskRepository.toggleTaskCompletion(userId, task);
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}