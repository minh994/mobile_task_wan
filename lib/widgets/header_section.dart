import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HeaderSection extends StatelessWidget {
  final String userName;
  final VoidCallback? onNotificationTap;

  const HeaderSection({
    super.key,
    required this.userName,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome'.tr + ' ${userName.tr}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Have a nice day!'.tr,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue.withOpacity(0.1),
          ),
          child: IconButton(
            onPressed: onNotificationTap,
            icon: const Icon(Icons.notifications_outlined),
            color: const Color(0xFF0066FF),
          ),
        ),
      ],
    );
  }
} 