import 'package:get/get.dart';
import 'package:flutter/material.dart';

abstract class BaseController extends GetxController {
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  // Hiển thị loading
  void showLoading() {
    _isLoading.value = true;
  }

  // Ẩn loading
  void hideLoading() {
    _isLoading.value = false;
  }

  // Hiển thị lỗi
  void showError(String message) {
    hideLoading();
    Get.snackbar(
      'error'.tr,
      message.tr,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  // Xử lý lỗi chung
  Future<T?> handleError<T>(Future<T> Function() action) async {
    try {
      showLoading();
      final result = await action();
      return result;
    } catch (e) {
      showError(e.toString());
      return null;
    } finally {
      hideLoading();
    }
  }

  // Clear error
  void clearError() {
    _errorMessage.value = '';
  }

  void showMessage(String message) {
    Get.snackbar(
      'notification'.tr,
      message.tr,
    );
  }

  void showSuccess(String message) {
    hideLoading();
    Get.snackbar(
      'success'.tr,
      message.tr,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
