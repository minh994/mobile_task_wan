import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/controllers/profile_controller.dart';
import '../core/base/base_controller.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import 'package:intl/intl.dart';

class MyProfileController extends BaseController {
  final _authService = Get.find<AuthService>();
  final _userService = Get.find<UserService>();
  final _imagePicker = ImagePicker();

  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final emailController = TextEditingController();
  
  final dateOfBirth = DateTime.now().obs;
  final photoUrl = ''.obs;

  String get formattedDate => 
      DateFormat('MMM dd, yyyy').format(dateOfBirth.value);

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      showLoading();
      final currentUser = _authService.currentUser.value;
      if (currentUser != null) {
        // Load data from Firebase Auth
        nameController.text = currentUser.displayName ?? '';
        emailController.text = currentUser.email ?? '';
        photoUrl.value = currentUser.photoURL ?? '';

        // Load additional data from Firestore
        await _userService.loadUser(currentUser.uid);
        final userData = _userService.currentUser.value;
        if (userData != null) {
          if (nameController.text.isEmpty) {
            nameController.text = userData.name;
          }
          professionController.text = userData.occupation;
          if (userData.photoUrl.isNotEmpty) {
            photoUrl.value = userData.photoUrl;
          }
        }
      }
      hideLoading();
    } catch (e) {
      hideLoading();
      showError('Error loading user data: $e');
    }
  }

  Future<void> pickImage() async {
    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      
      if (image != null) {
        showLoading();
        final userId = _authService.currentUser.value?.uid;
        if (userId != null) {
          // Cập nhật URL ảnh trong database
          await _userService.updateUser(userId, {
            'photoUrl': image.path, // Lưu đường dẫn ảnh local
          });

          // Cập nhật Firebase Auth
          await _authService.currentUser.value?.updatePhotoURL(image.path);
          
          // Cập nhật local state
          photoUrl.value = image.path;
          
          // Cập nhật lại ProfileController
          final profileController = Get.find<ProfileController>();
          profileController.photoUrl.value = image.path;
        }
        hideLoading();
      }
    } catch (e) {
      hideLoading();
      showError('Error picking image: $e');
    }
  }

  Future<void> saveProfile() async {
    try {
      showLoading();
      final userId = _authService.currentUser.value?.uid;
      if (userId != null) {
        // Cập nhật displayName trong Firebase Auth
        await _authService.currentUser.value?.updateDisplayName(nameController.text);
        
        // Cập nhật database
        final userData = {
          'name': nameController.text,
          'occupation': professionController.text,
          'photoUrl': photoUrl.value,
        };
        
        await _userService.updateUser(userId, userData);

        // Cập nhật lại ProfileController
        final profileController = Get.find<ProfileController>();
        profileController.name.value = nameController.text;
        profileController.occupation.value = professionController.text;
        profileController.photoUrl.value = photoUrl.value;

        hideLoading();
        Get.back();
        showMessage('Profile updated successfully');
      }
    } catch (e) {
      hideLoading();
      showError('Error updating profile: $e');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    professionController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
