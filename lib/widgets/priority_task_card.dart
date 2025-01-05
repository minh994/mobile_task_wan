import 'package:flutter/material.dart';
import '../models/task.dart';

class PriorityTaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  const PriorityTaskCard({
    super.key,
    required this.task,
    this.onTap,
  });

  Widget _getTaskIcon() {
    switch (task.type?.toLowerCase()) {
      case 'ui design':
        return const Icon(Icons.brush_outlined, color: Colors.white, size: 24);
      case 'laravel':
        return Image.asset('assets/laravel_icon.png', width: 24, height: 24);
      case 'edit':
        return const Icon(Icons.edit_outlined, color: Colors.white, size: 24);
      default:
        return const Icon(Icons.task_outlined, color: Colors.white, size: 24);
    }
  }

  Color _getCardColor() {
    switch (task.type?.toLowerCase()) {
      case 'ui design':
        return const Color(0xFF0066FF);
      case 'laravel':
        return const Color(0xFF4A3675);
      case 'edit':
        return const Color(0xFFFF3B30);
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _getCardColor(),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${task.dueDate} days',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                _getTaskIcon(),
              ],
            ),
            const Spacer(),
            Text(
              task.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Progress',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: task.progress,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 