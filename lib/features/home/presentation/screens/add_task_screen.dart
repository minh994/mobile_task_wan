import 'package:flutter/material.dart';
import '../../domain/models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _todoController = TextEditingController();
  String _selectedCategory = 'Priority Task';
  DateTime? _endDate;
  List<String> _todoItems = [];

  @override
  void initState() {
    super.initState();
    _endDate = DateTime.now().add(const Duration(days: 7));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _todoController.dispose();
    super.dispose();
  }

  void _addTodoItem() {
    if (_todoController.text.trim().isNotEmpty) {
      setState(() {
        _todoItems.add(_todoController.text.trim());
        _todoController.clear();
      });
    }
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _saveTask() {
    if (_titleController.text.isEmpty) return;

    final task = Task(
      id: DateTime.now().toString(),
      title: _titleController.text,
      description: _descriptionController.text,
      dueDate: _endDate ?? DateTime.now().add(const Duration(days: 7)),
      type: _selectedCategory,
      priority: TaskPriority.medium,
      progress: 0.0,
      color: const Color(0xFF0066FF),
      todoItems: _todoItems,
    );

    Navigator.pop(context, task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0066FF),
        elevation: 0,
        title: const Text(
          'Add Task',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _saveTask,
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF0066FF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.design_services,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'New Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateSection(),
                  const SizedBox(height: 24),
                  _buildTitleSection(),
                  const SizedBox(height: 24),
                  _buildCategorySection(),
                  const SizedBox(height: 24),
                  _buildDescriptionSection(),
                  const SizedBox(height: 24),
                  _buildTodoListSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSection() {
    // Copy từ EditTaskScreen
    return Container(); // Placeholder - copy implementation từ EditTaskScreen
  }

  Widget _buildTitleSection() {
    // Copy từ EditTaskScreen
    return Container(); // Placeholder - copy implementation từ EditTaskScreen
  }

  Widget _buildCategorySection() {
    // Copy từ EditTaskScreen
    return Container(); // Placeholder - copy implementation từ EditTaskScreen
  }

  Widget _buildDescriptionSection() {
    // Copy từ EditTaskScreen
    return Container(); // Placeholder - copy implementation từ EditTaskScreen
  }

  Widget _buildTodoListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'To do list',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _todoController,
          decoration: InputDecoration(
            hintText: 'Add new task',
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(12),
            suffixIcon: IconButton(
              icon: const Icon(Icons.add, color: Color(0xFF0066FF)),
              onPressed: _addTodoItem,
            ),
          ),
          onSubmitted: (_) => _addTodoItem(),
        ),
        if (_todoItems.isNotEmpty) ...[
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _todoItems.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _todoItems[index],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => _removeTodoItem(index),
                  ),
                ],
              );
            },
          ),
        ],
      ],
    );
  }
} 