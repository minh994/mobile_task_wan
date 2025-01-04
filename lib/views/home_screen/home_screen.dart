import 'package:flutter/material.dart';
import 'package:mobile_app/controllers/home_controller.dart';
import 'package:mobile_app/services/task_service.dart';
import '../../../../core/base/base_view.dart';
import 'package:get/get.dart';
import '../../../../models/task.dart';

class HomeScreen extends BaseView<HomeController> {
  HomeScreen({super.key});

  final _taskService = Get.find<TaskService>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Get.toNamed('/profile'),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTaskCategories(),
          Expanded(
            child: _buildTaskList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskCategories() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: const [
          // _buildCategoryCard(
          //   'Tất cả',
          //   Icons.list,
          //   Colors.blue,
          //   () => controller.loadTasks(),
          // ),
          // _buildCategoryCard(
          //   'Ưu tiên',
          //   Icons.star,
          //   Colors.orange,
          //   () => controller.loadPriorityTasks(),
          // ),
          // _buildCategoryCard(
          //   'Hoàn thành',
          //   Icons.check_circle,
          //   Colors.green,
          //   () => controller.loadCompletedTasks(),
          // ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return Obx(() {
      if (_taskService.tasks.isEmpty) {
        return const Center(
          child: Text('Chưa có công việc nào'),
        );
      }

      return ListView.builder(
        itemCount: _taskService.tasks.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final task = _taskService.tasks[index];
          return _buildTaskItem(task);
        },
      );
    });
  }

  Widget _buildTaskItem(Task task) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) =>
              _taskService.updateTask(task.copyWith(isCompleted: value)),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(task.description),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _showDeleteConfirmation(task),
        ),
      ),
    );
  }

  void _showAddTaskDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Thêm công việc mới'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Tiêu đề',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Mô tả',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final task = Task(
                  id: '',
                  title: titleController.text,
                  description: descriptionController.text,
                  isCompleted: false,
                  createdAt: DateTime.now(),
                  dueDate: DateTime.now(),
                  priority: TaskPriority.low,
                );
                _taskService.addTask(task);
                Get.back();
              }
            },
            child: const Text('Thêm'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(Task task) {
    Get.dialog(
      AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc chắn muốn xóa công việc này?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              _taskService.deleteTask(task.id);
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}
