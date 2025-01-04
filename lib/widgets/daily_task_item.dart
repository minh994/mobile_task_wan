import 'package:flutter/material.dart';
import '../models/task.dart';

class DailyTaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback? onToggle;

  const DailyTaskItem({
    super.key,
    required this.task,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onToggle,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: task.isCompleted ? const Color(0xFF0066FF) : Colors.grey[300]!,
            width: 2,
          ),
          color: task.isCompleted ? const Color(0xFF0066FF) : Colors.white,
        ),
        child: task.isCompleted
            ? const Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              )
            : null,
      ),
      title: Text(
        task.title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: task.isCompleted ? Colors.grey : Colors.black87,
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
} 