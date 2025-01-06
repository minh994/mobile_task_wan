import 'package:get/get.dart';

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
    _errorMessage.value = message;
    Get.snackbar(
      'Lỗi',
      message,
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
      'Thông báo',
      message,
    );
  }
}
