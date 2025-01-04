// import 'package:flutter/material.dart';
// import '../../../../core/di/service_locator.dart';
// import '../../../../services/task_service.dart';
// import '../../../../widgets/calendar_picker.dart';
// import '../../../../models/task.dart';

// class CalendarScreen extends StatefulWidget {
//   const CalendarScreen({super.key});

//   @override
//   State<CalendarScreen> createState() => _CalendarScreenState();
// }

// class _CalendarScreenState extends State<CalendarScreen> {
//   final DateTime _selectedDate = DateTime.now();
//   final List<DateTime> _weekDays = [];
//   String _selectedTab = 'Priority Task';
//   final _taskService = getIt<TaskService>();

//   @override
//   void initState() {
//     super.initState();
//     _generateWeekDays();
//   }

//   void _generateWeekDays() {
//     final DateTime now = DateTime.now();
//     final DateTime firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
    
//     for (int i = 0; i < 7; i++) {
//       _weekDays.add(firstDayOfWeek.add(Duration(days: i)));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Row(
//           children: [
//             const Text(
//               'Feb, 2022',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.black87,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const Icon(Icons.arrow_drop_down, color: Colors.black87),
//           ],
//         ),
//       ),
//       body: ValueListenableBuilder(
//         valueListenable: _taskService,
//         builder: (context, tasks, _) {
//           if (_taskService.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return Column(
//             children: [
//               CalendarPicker(
//                 selectedDate: _selectedDate,
//                 onDateSelected: (date) {
//                   // Handle date selection
//                 },
//               ),
//               const SizedBox(height: 20),
//               _buildTabBar(),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: _selectedTab == 'Priority Task'
//                     ? _buildPriorityTasks(tasks)
//                     : _buildDailyTasks(tasks),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTabBar() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _buildTab('Priority Task'),
//         _buildTab('Daily Task'),
//       ],
//     );
//   }

//   Widget _buildTab(String title) {
//     final isSelected = _selectedTab == title;
//     return GestureDetector(
//       onTap: () => setState(() => _selectedTab = title),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF0066FF) : Colors.transparent,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.grey,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPriorityTasks(List<Task> tasks) {
//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         final task = tasks[index];
//         if (task.priority == TaskPriority.high) {
//           return _buildTaskCard(task);
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }

//   Widget _buildDailyTasks(List<Task> tasks) {
//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         final task = tasks[index];
//         return _buildDailyTaskItem(task);
//       },
//     );
//   }

//   Widget _buildTaskCard(Task task) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         title: Text(task.title),
//         subtitle: Text(task.description),
//         trailing: Checkbox(
//           value: task.isCompleted,
//           onChanged: (value) {
//             // Handle task completion
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildDailyTaskItem(Task task) {
//     return ListTile(
//       leading: Checkbox(
//         value: task.isCompleted,
//         onChanged: (value) {
//           // Handle task completion
//         },
//       ),
//       title: Text(task.title),
//     );
//   }
// } 