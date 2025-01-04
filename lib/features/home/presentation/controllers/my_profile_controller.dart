import 'package:flutter/material.dart';
import '../../../../core/di/service_locator.dart';
import '../../services/user_service.dart';
import '../../domain/models/user.dart';

class MyProfileController {
  final _userService = getIt<UserService>();
  final nameController = TextEditingController();
  final occupationController = TextEditingController();
  final locationController = TextEditingController();

  void initializeControllers(User? user) {
    if (user != null) {
      nameController.text = user.name;
      occupationController.text = user.occupation;
      locationController.text = user.location;
    }
  }

  Future<void> updateProfile() async {
    final currentUser = _userService.value;
    if (currentUser != null) {
      final updatedUser = currentUser.copyWith(
        name: nameController.text,
        occupation: occupationController.text,
        location: locationController.text,
      );
      await _userService.updateUser(updatedUser);
    }
  }

  void dispose() {
    nameController.dispose();
    occupationController.dispose();
    locationController.dispose();
  }
} 