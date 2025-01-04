// import 'package:flutter/material.dart';
// import 'package:mobile_app/controllers/task_controller.dart';
// import '../../core/base/base_view.dart';
// import 'package:get/get.dart';

// class TasksScreen extends BaseView<TaskController> {
//   const TasksScreen({super.key});

//   @override
//   Widget buildView(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Công việc'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.filter_list),
//             onPressed: controller.showFilterOptions,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           TaskFilter(
//             selectedFilter: controller.currentFilter,
//             onFilterChanged: controller.changeFilter,
//           ),
//           Expanded(
//             child: Obx(() {
//               if (controller.tasks.isEmpty) {
//                 return const Center(
//                   child: Text('Chưa có công việc nào'),
//                 );
//               }
//               return ListView.builder(
//                 itemCount: controller.tasks.length,
//                 itemBuilder: (context, index) {
//                   final task = controller.tasks[index];
//                   return TaskListItem(
//                     task: task,
//                     onToggle: controller.toggleTaskStatus,
//                     onDelete: controller.deleteTask,
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: controller.addNewTask,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
