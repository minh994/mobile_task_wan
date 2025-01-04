// import 'package:flutter/material.dart';
// import '../../core/base/base_view.dart';
// import '../../controllers/verification_success_controller.dart';

// class VerificationSuccessScreen
//     extends BaseView<VerificationSuccessController> {
//   const VerificationSuccessScreen({super.key});

//   @override
//   Widget buildView(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/verification_success.png',
//                 height: 200,
//               ),
//               const SizedBox(height: 32),
//               Text(
//                 'Xác thực thành công!',
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 'Tài khoản của bạn đã được xác thực thành công',
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 32),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: controller.goToHome,
//                   child: const Text('Bắt đầu sử dụng'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
