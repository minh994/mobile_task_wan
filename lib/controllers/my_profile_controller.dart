import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/user_service.dart';
import '../models/user.dart';
import '../core/base/base_controller.dart';

class MyProfileController extends BaseController {
  final UserService _userService = Get.find<UserService>();

  final nameController = TextEditingController();
  final occupationController = TextEditingController();
  final locationController = TextEditingController();

  void initializeControllers(UserModel? user) {
    if (user != null) {
      nameController.text = user.name;
      occupationController.text = user.occupation;
      locationController.text = user.location;
    }
  }

  Future<void> updateProfile() async {
    await handleError(() async {
      final currentUser = _userService.currentUser.value;
      if (currentUser != null) {
        final updatedUser = currentUser.copyWith(
          name: nameController.text,
          occupation: occupationController.text,
          location: locationController.text,
        );
        await _userService.updateUser(currentUser.id, updatedUser.toFirestore());
        showMessage('Cập nhật thông tin thành công');
      }
    });
  }

  @override
  void onClose() {
    nameController.dispose();
    occupationController.dispose();
    locationController.dispose();
    super.onClose();
  }
}
