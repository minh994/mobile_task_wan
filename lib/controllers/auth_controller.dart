import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final _authService = Get.find<AuthService>();
  final isLoading = false.obs;
  final isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    _authService.currentUser.listen((User? user) {
      isAuthenticated.value = user != null;
    });
  }

  // Thêm các phương thức xử lý authentication
}
