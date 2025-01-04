import 'package:get/get.dart';
import 'package:mobile_app/views/home_screen/home_screen.dart';
import 'package:mobile_app/views/home_screen/home_screen_binding.dart';
import 'package:mobile_app/views/login_screen/login_binding.dart';
import 'package:mobile_app/views/login_screen/login_screen.dart';
import 'package:mobile_app/views/register_screen/register_binding.dart';
import 'package:mobile_app/views/register_screen/register_screen.dart';
import 'package:mobile_app/views/verify_email_screen/verify_email_screen.dart';
import 'package:mobile_app/views/verify_email_screen/verify_email_binding.dart';
import 'package:mobile_app/views/verify_success_screen/verify_success_screen.dart';

class AppRouter {
  static const defaultRoute = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';

  static final routes = [
    GetPage(
      name: defaultRoute,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/verify-email',
      page: () => const VerifyEmailScreen(),
      binding: VerifyEmailBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: '/verify-success',
      page: () => const VerifySuccessScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
