import 'package:get/get.dart';
import 'package:mobile_app/views/auth/bindings/auth_binding.dart';
import 'package:mobile_app/views/home_screen/home_screen.dart';
import 'package:mobile_app/views/home_screen/home_screen_binding.dart';
import 'package:mobile_app/views/login_screen/login_binding.dart';
import 'package:mobile_app/views/login_screen/login_screen.dart';
import 'package:mobile_app/views/register_screen/register_screen.dart';

class AppRouter {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const defaultRoute = '/';

  static final routes = [
    GetPage(
      name: defaultRoute,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    // GetPage(
    //   name: '/verify',
    //   page: () => VerifyAccountScreen(
    //     email: Get.arguments['email'],
    //   ),
    //   binding: AuthBinding(),
    // ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
