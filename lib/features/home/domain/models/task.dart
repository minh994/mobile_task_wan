import 'package:flutter/material.dart';

enum TaskPriority { low, medium, high }

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final TaskPriority priority;
  final bool isCompleted;
  final String? type;
  final double progress;
  final Color color;
  final List<String> todoItems;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
    this.type,
    this.progress = 0.0,
    this.color = Colors.blue,
    this.todoItems = const [],
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Getter để tính số ngày còn lại
  int get daysRemaining {
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;
    return difference < 0 ? 0 : difference;
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    TaskPriority? priority,
    bool? isCompleted,
    String? type,
    double? progress,
    Color? color,
    List<String>? todoItems,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      type: type ?? this.type,
      progress: progress ?? this.progress,
      color: color ?? this.color,
      todoItems: todoItems ?? this.todoItems,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority.index,
      'isCompleted': isCompleted,
      'type': type,
      'progress': progress,
      'color': color.value,
      'todoItems': todoItems,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Task.fromFirestore(String id, Map<String, dynamic> data) {
    return Task(
      id: id,
      title: data['title'] as String,
      description: data['description'] as String,
      dueDate: DateTime.parse(data['dueDate'] as String),
      priority: TaskPriority.values[data['priority'] as int],
      isCompleted: data['isCompleted'] as bool,
      type: data['type'] as String?,
      progress: (data['progress'] as num).toDouble(),
      color: Color(data['color'] as int),
      todoItems: List<String>.from(data['todoItems'] as List),
      createdAt: DateTime.parse(data['createdAt'] as String),
      updatedAt: data['updatedAt'] != null 
        ? DateTime.parse(data['updatedAt'] as String)
        : null,
    );
  }
} 