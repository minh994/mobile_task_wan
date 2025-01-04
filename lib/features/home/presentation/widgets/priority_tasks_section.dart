import 'package:flutter/material.dart';
import '../../domain/models/task.dart';
import '../widgets/priority_task_card.dart';

class PriorityTasksSection extends StatelessWidget {
  final List<Task> tasks;

  const PriorityTasksSection({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'My Priority Task',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return PriorityTaskCard(task: task);
            },
          ),
        ),
      ],
    );
  }
} 