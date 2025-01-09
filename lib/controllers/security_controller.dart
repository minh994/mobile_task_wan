import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/base/base_controller.dart';
import '../services/auth_service.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';

class SecurityController extends BaseController {
  final _authService = Get.find<AuthService>();
  
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isCurrentPasswordVisible = false.obs;
  final isNewPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  
  final currentLocation = ''.obs;
  final isActive = true.obs;
  final loc.Location location = loc.Location();

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> getCurrentLocation() async {
    try {
      showLoading();
      
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          hideLoading();
          currentLocation.value = 'location_disabled'.tr;
          return;
        }
      }

      var permission = await location.hasPermission();
      if (permission == loc.PermissionStatus.denied) {
        permission = await location.requestPermission();
        if (permission != loc.PermissionStatus.granted) {
          hideLoading();
          currentLocation.value = 'location_permission_denied'.tr;
          return;
        }
      }

      // Cấu hình độ chính xác cao cho location
      await location.changeSettings(
        accuracy: loc.LocationAccuracy.high,
        interval: 1000,
      );

      final locationData = await location.getLocation();
      
      final placemarks = await placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );
      
      if (placemarks.isNotEmpty) {
        final place = placemarks[0];
        final List<String> addressParts = [];

        // Thêm các thành phần địa chỉ theo thứ tự từ chi tiết đến tổng quát
        if (place.street?.isNotEmpty == true) {
          addressParts.add(place.street!);
        }
        if (place.subLocality?.isNotEmpty == true) {
          addressParts.add(place.subLocality!);
        }
        if (place.locality?.isNotEmpty == true) {
          addressParts.add(place.locality!);
        }
        if (place.administrativeArea?.isNotEmpty == true) {
          addressParts.add(place.administrativeArea!);
        }
        if (place.country?.isNotEmpty == true) {
          addressParts.add(place.country!);
        }

        // Kết hợp các phần địa chỉ
        if (addressParts.isNotEmpty) {
          currentLocation.value = addressParts.join(', ');
        } else {
          currentLocation.value = 'unknown_location'.tr;
        }
      }

      hideLoading();
    } catch (e) {
      hideLoading();
      print('error_location'.tr + e.toString());
      currentLocation.value = 'unknown_location'.tr;
    }
  }

  Future<void> changePassword() async {
    try {
      if (currentPasswordController.text.isEmpty ||
          newPasswordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty) {
        showError('fill_all_fields'.tr);
        return;
      }

      if (newPasswordController.text != confirmPasswordController.text) {
        showError('password_mismatch'.tr);
        return;
      }

      await getCurrentLocation();
      showLoading();
      
      await _authService.reauthenticate(currentPasswordController.text);
      await _authService.changePassword(newPasswordController.text);
      
      hideLoading();
      Get.back();
      showSuccess('password_changed'.tr);
    } catch (e) {
      hideLoading();
      showError('password_error'.tr);
    }
  }
} 