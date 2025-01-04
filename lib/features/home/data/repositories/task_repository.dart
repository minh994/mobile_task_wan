import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/task.dart';
import 'package:flutter/foundation.dart';

class TaskRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _tasksCollection(String userId) => 
      _firestore.collection('users/$userId/tasks');

  // Create new task
  Future<void> createTask(String userId, Task task) async {
    try {
      await _tasksCollection(userId).add(task.toFirestore());
    } catch (e) {
      _logError('Error creating task', e);
      rethrow;
    }
  }

  // Get all tasks for a user
  Stream<List<Task>> getTasks(String userId) {
    return _tasksCollection(userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Task.fromFirestore(doc.id, doc.data());
      }).toList();
    });
  }

  // Update task
  Future<void> updateTask(String userId, Task task) async {
    try {
      await _tasksCollection(userId).doc(task.id).update({
        ...task.toFirestore(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      _logError('Error updating task', e);
      rethrow;
    }
  }

  // Delete task
  Future<void> deleteTask(String userId, String taskId) async {
    try {
      await _tasksCollection(userId).doc(taskId).delete();
    } catch (e) {
      _logError('Error deleting task', e);
      rethrow;
    }
  }

  // Toggle task completion
  Future<void> toggleTaskCompletion(String userId, Task task) async {
    try {
      await _tasksCollection(userId).doc(task.id).update({
        'isCompleted': !task.isCompleted,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      _logError('Error toggling task completion', e);
      rethrow;
    }
  }

  // Get priority tasks
  Stream<List<Task>> getPriorityTasks(String userId) {
    return _tasksCollection(userId)
        .where('priority', isGreaterThan: 0) // Medium or High priority
        .where('isCompleted', isEqualTo: false)
        .orderBy('priority', descending: true)
        .orderBy('dueDate')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Task.fromFirestore(doc.id, doc.data());
      }).toList();
    });
  }

  void _logError(String message, dynamic error) {
    // TODO: Implement proper logging
    assert(() {
      debugPrint('$message: $error');
      return true;
    }());
  }
} 