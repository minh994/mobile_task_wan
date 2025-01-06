import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/core/constants/app_colors.dart';

enum TaskPriority { low, medium, high }

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime dueDate;
  final String type;
  final bool isCompleted;
  final List<String> todoItems;
  final Color color;
  final TaskPriority priority;
  final double progress;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.dueDate,
    required this.type,
    this.isCompleted = false,
    this.todoItems = const [],
    this.color = AppColors.primary,
    this.priority = TaskPriority.medium,
    this.progress = 0.0,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      dueDate: (json['dueDate'] as Timestamp).toDate(),
      type: json['type'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      todoItems: List<String>.from(json['todoItems'] ?? []),
      color: Color(json['color'] as int? ?? AppColors.primary.value),
      priority: TaskPriority.values[json['priority'] as int? ?? 1], // Default medium
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'dueDate': Timestamp.fromDate(dueDate),
      'type': type,
      'isCompleted': isCompleted,
      'todoItems': todoItems,
      'color': color.value,
      'priority': priority.index,
      'progress': progress,
    };
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? dueDate,
    String? type,
    bool? isCompleted,
    List<String>? todoItems,
    Color? color,
    TaskPriority? priority,
    double? progress,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      type: type ?? this.type,
      isCompleted: isCompleted ?? this.isCompleted,
      todoItems: todoItems ?? this.todoItems,
      color: color ?? this.color,
      priority: priority ?? this.priority,
      progress: progress ?? this.progress,
    );
  }

  // Helper methods
  Color get priorityColor {
    switch (priority) {
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.low:
        return Colors.green;
    }
  }

  String get priorityText {
    switch (priority) {
      case TaskPriority.high:
        return 'High Priority';
      case TaskPriority.medium:
        return 'Medium Priority';
      case TaskPriority.low:
        return 'Low Priority';
    }
  }

  // Calculate days remaining
  int get daysRemaining {
    final now = DateTime.now();
    return dueDate.difference(now).inDays;
  }

  // Calculate progress based on completed todo items
  double calculateProgress() {
    if (todoItems.isEmpty) return 0.0;
    final completedItems = todoItems.where((item) => item.startsWith('✓')).length;
    return completedItems / todoItems.length;
  }
} 