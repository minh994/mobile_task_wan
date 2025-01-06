import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/core/constants/app_colors.dart';
import '../core/base/base_controller.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import 'package:image_picker/image_picker.dart';
import '../core/routes/app_router.dart';

class MyProfileController extends BaseController {
  final _authService = Get.find<AuthService>();
  final _userService = Get.find<UserService>();
  final _imagePicker = ImagePicker();

  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final emailController = TextEditingController();
  
  final dateOfBirth = DateTime.now().obs;
  final photoUrl = ''.obs;

  // Ngày tạm thời được chọn trong calendar
  final tempSelectedDate = DateTime.now().obs;

  String get formattedDate => 
      DateFormat('MMM dd, yyyy').format(dateOfBirth.value);

  @override
  void onInit() {
    super.onInit();
    tempSelectedDate.value = dateOfBirth.value;
    _checkAuth();
    loadUserData();
  }

  Future<void> _checkAuth() async {
    if (!_authService.isAuthenticated) {
      Get.offAllNamed(AppRouter.login);
      return;
    }
    
    final isValid = await _authService.validateToken();
    if (!isValid) {
      showError('Phiên đăng nhập đã hết hạn');
      Get.offAllNamed(AppRouter.login);
    }
  }

  Future<void> loadUserData() async {
    try {
      print('Loading user data...');
      showLoading();
      final userId = _authService.currentUser.value?.uid;
      if (userId != null) {
        await _userService.loadUser(userId);
        final user = _userService.currentUser.value;
        if (user != null) {
          nameController.text = user.name;
          professionController.text = user.occupation;
          emailController.text = user.email;
          photoUrl.value = user.photoUrl;
          print('User data loaded successfully');
        }
      }
      hideLoading();
    } catch (e) {
      hideLoading();
      print('Error loading user data: $e');
      showError('Error loading user data: $e');
    }
  }

  // Chọn ngày tạm thời
  void selectDate(DateTime date) {
    tempSelectedDate.value = date;
  }

  // Xác nhận chọn ngày
  void confirmDateSelection() {
    dateOfBirth.value = tempSelectedDate.value;
  }

  // Hiển thị dialog chỉnh sửa
  void _showEditDialog(String title, TextEditingController controller) {
    final tempController = TextEditingController(text: controller.text);
    
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit $title',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: tempController,
                decoration: InputDecoration(
                  hintText: 'Enter $title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      controller.text = tempController.text;
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        // TODO: Upload image to storage and update photoUrl
        showMessage('Image picked successfully');
      }
    } catch (e) {
      showError('Error picking image: $e');
    }
  }

  Future<void> saveProfile() async {
    try {
      showLoading();
      final userId = _authService.currentUser.value?.uid;
      if (userId != null) {
        await _userService.updateUser(userId, {
          'name': nameController.text,
          'occupation': professionController.text,
          'photoUrl': photoUrl.value,
        });
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
