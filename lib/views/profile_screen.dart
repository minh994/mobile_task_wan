// import 'package:flutter/material.dart';
// import '../../../../core/di/service_locator.dart';
// import '../../../../services/user_service.dart';
// import '../../../../models/user.dart' as app_user;

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final userService = getIt<UserService>();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Profile')),
//       body: ValueListenableBuilder<app_user.User?>(
//         valueListenable: userService,
//         builder: (context, user, _) {
//           if (userService.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (user == null) {
//             return const Center(child: Text('No user data'));
//           }

//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: user.photoUrl.isNotEmpty 
//                     ? NetworkImage(user.photoUrl) 
//                     : null,
//                 ),
//                 const SizedBox(height: 16),
//                 Text('Name: ${user.name}'),
//                 Text('Email: ${user.email}'),
//                 Text('Location: ${user.location}'),
//                 Text('Occupation: ${user.occupation}'),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// } 