import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/models/task.dart';

class TaskService extends GetxService {
  final _db = FirebaseFirestore.instance;
  final RxList<Task> tasks = <Task>[].obs;

  @override
  Future<TaskService> init() async {
    await loadTasks('123');
    return this;
  }

  // Load tasks của user
  Future<List<Task>> loadTasks(String userId) async {
    try {
      final snapshot = await _db
          .collection('tasks')
          .where('userId', isEqualTo: userId)
          .get();

      final loadedTasks = snapshot.docs
          .map((doc) => Task.fromFirestore(doc.id, doc.data()))
          .toList();

      tasks.value = loadedTasks;
      return loadedTasks;
    } catch (e) {
      throw Exception('Không thể tải danh sách công việc: $e');
    }
  }

  // Thêm task mới
  Future<Task> addTask(Task task) async {
    try {
      final doc = await _db.collection('tasks').add(task.toFirestore());
      task = task.copyWith(id: doc.id);
      tasks.add(task);
      return task;
    } catch (e) {
      throw Exception('Thêm công việc thất bại: $e');
    }
  }

  // Cập nhật task
  Future<void> updateTask(Task task) async {
    try {
      await _db.collection('tasks').doc(task.id).update(task.toFirestore());
      final index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        tasks[index] = task;
      }
    } catch (e) {
      throw Exception('Cập nhật công việc thất bại: $e');
    }
  }

  // Xóa task
  Future<void> deleteTask(String taskId) async {
    try {
      await _db.collection('tasks').doc(taskId).delete();
      tasks.removeWhere((task) => task.id == taskId);
    } catch (e) {
      throw Exception('Xóa công việc thất bại: $e');
    }
  }
}
