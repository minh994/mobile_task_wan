import 'package:flutter/material.dart';
import '../../../../core/di/service_locator.dart';
import '../../services/task_service.dart';
import '../../../auth/services/auth_service.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final _taskService = getIt<TaskService>();
  final _authService = getIt<AuthService>();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    if (_authService.value?.uid != null) {
      await _taskService.loadTasks(_authService.value!.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _taskService,
        builder: (context, tasks, _) {
          if (_taskService.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_taskService.error != null) {
            return Center(child: Text('Error: ${_taskService.error}'));
          }

          if (tasks.isEmpty) {
            return const Center(child: Text('No tasks found'));
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) async {
                    if (_authService.value?.uid != null) {
                      await _taskService.toggleTaskStatus(
                        _authService.value!.uid,
                        task.id,
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add task screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} 