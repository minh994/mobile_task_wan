// import 'package:flutter/material.dart';
// import '../../core/base/base_view.dart';
// import 'package:get/get.dart';

// class ProfileScreen extends BaseView<ProfileController> {
//   const ProfileScreen({super.key});

//   @override
//   Widget buildView(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hồ sơ'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: controller.editProfile,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Obx(() => ProfileHeader(user: controller.user.value)),
//             const Divider(),
//             ProfileMenuItem(
//               icon: Icons.notifications,
//               title: 'Thông báo',
//               onTap: controller.goToNotifications,
//             ),
//             ProfileMenuItem(
//               icon: Icons.security,
//               title: 'Bảo mật',
//               onTap: controller.goToSecurity,
//             ),
//             ProfileMenuItem(
//               icon: Icons.logout,
//               title: 'Đăng xuất',
//               onTap: controller.logout,
//               isDestructive: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
