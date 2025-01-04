// import 'package:flutter/material.dart';
// import '../../core/base/base_view.dart';
// import '../../controllers/calendar_controller.dart';
// import 'package:get/get.dart';
// import 'widgets/calendar_task_list.dart';
// import 'widgets/custom_calendar.dart';

// class CalendarScreen extends BaseView<CalendarController> {
//   const CalendarScreen({super.key});

//   @override
//   Widget buildView(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lịch'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.today),
//             onPressed: controller.goToToday,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           CustomCalendar(
//             selectedDate: controller.selectedDate,
//             onDateSelected: controller.onDateSelected,
//           ),
//           const Divider(),
//           Expanded(
//             child: CalendarTaskList(
//               tasks: controller.tasksForSelectedDate,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
