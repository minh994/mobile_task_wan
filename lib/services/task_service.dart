import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/task.dart';

class TaskService extends GetxService {
  final _firestore = FirebaseFirestore.instance;
  final tasks = <Task>[].obs;

  // Cache data
  final _cache = <String, List<Task>>{};

  Future<void> loadTasks(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .orderBy('createdAt', descending: true)
          .get();

      tasks.value = snapshot.docs
          .map((doc) => Task.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      print('Error loading tasks: $e');
      rethrow;
    }
  }

  Future<void> addTask(Task task, String userId) async {
    try {
      final taskData = task.toJson();
      
      final docRef = await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .add(taskData);

      final newTask = task.copyWith(id: docRef.id);
      
      tasks.add(newTask);
      tasks.refresh();

    } catch (e) {
      print('Error adding task: $e');
      rethrow;
    }
  }

  Future<void> updateTask(Task task, String userId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(task.id)
          .update(task.toJson());

      final index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        tasks[index] = task;
      }

      await loadTasks(userId);
    } catch (e) {
      print('Error updating task: $e');
      rethrow;
    }
  }

  Future<void> deleteTask(String taskId, String userId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .delete();

      tasks.removeWhere((task) => task.id == taskId);
      
      await loadTasks(userId);
      
      tasks.refresh();
    } catch (e) {
      print('Error deleting task: $e');
      rethrow;
    }
  }

  Future<List<Task>> getTasksByDate(DateTime date, String userId) async {
    final cacheKey = '${date.toString()}_$userId';
    
    // Check cache first
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    try {
      final tasks = await _loadTasksFromFirestore(date, userId);
      _cache[cacheKey] = tasks;
      return tasks;
    } catch (e) {
      print('Error getting tasks by date: $e');
      return [];
    }
  }

  void clearCache() {
    _cache.clear();
  }

  Future<List<Task>> _loadTasksFromFirestore(DateTime date, String userId) async {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .where('createdAt', isGreaterThanOrEqualTo: startOfDay)
          .where('createdAt', isLessThan: endOfDay)
          .get();

      final tasksForDate = snapshot.docs
          .map((doc) => Task.fromJson({...doc.data(), 'id': doc.id}))
          .toList();

      // Force UI update for calendar view
      tasks.refresh();
      
      return tasksForDate;
    } catch (e) {
      print('Error getting tasks by date: $e');
      return [];
    }
  }
}
