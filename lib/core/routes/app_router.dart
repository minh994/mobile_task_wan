import 'package:flutter/material.dart';
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
import 'package:mobile_app/views/task_detail_screen/task_detail_screen.dart';
import 'package:mobile_app/views/task_detail_screen/task_detail_binding.dart';
import 'package:mobile_app/views/add_task_screen/add_task_screen.dart';
import 'package:mobile_app/views/add_task_screen/add_task_binding.dart';
import 'package:mobile_app/views/calendar_screen/calendar_screen.dart';
import 'package:mobile_app/views/calendar_screen/calendar_binding.dart';
import 'package:mobile_app/views/edit_task_screen/edit_task_screen.dart';
import 'package:mobile_app/views/edit_task_screen/edit_task_binding.dart';
import 'package:mobile_app/views/profile_screen/profile_screen.dart';
import 'package:mobile_app/views/profile_screen/profile_binding.dart';
import 'package:mobile_app/views/my_profile_screen/my_profile_screen.dart';
import 'package:mobile_app/views/my_profile_screen/my_profile_binding.dart';
import 'package:mobile_app/services/auth_service.dart';
import 'package:mobile_app/views/statistic_screen/statistic_screen.dart';
import 'package:mobile_app/views/statistic_screen/statistic_binding.dart';
import 'package:mobile_app/views/settings_screen/settings_screen.dart';
import 'package:mobile_app/views/settings_screen/settings_binding.dart';
import 'package:mobile_app/views/location_screen/location_screen.dart';
import 'package:mobile_app/views/location_screen/location_binding.dart';
import 'package:mobile_app/views/notification_screen/notification_screen.dart';
import 'package:mobile_app/views/notification_screen/notification_binding.dart';
import 'package:mobile_app/views/security_screen/security_screen.dart';
import 'package:mobile_app/views/security_screen/security_binding.dart';
import 'package:mobile_app/views/language_screen/language_screen.dart';
import 'package:mobile_app/views/language_screen/language_binding.dart';

class AuthMiddleware extends GetMiddleware {
  // Kiểm tra và chuyển hướng các route cần xác thực
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();
    // Kiểm tra xác thực và chuyển về trang login nếu chưa đăng nhập
    if (!authService.isAuthenticated && 
        route != AppRouter.login && 
        route != AppRouter.register &&
        route != AppRouter.myProfile) {
      return const RouteSettings(name: AppRouter.login);
    }
    return null;
  }
}

class AppRouter {
  static const defaultRoute = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const taskDetail = '/task-detail';
  static const addTask = '/add-task';
  static const calendar = '/calendar';
  static const verifyEmail = '/verify-email';
  static const verifySuccess = '/verify-success';
  static const editTask = '/edit-task';
  static const profile = '/profile';
  static const priorityTask = '/priority-task';
  static const myProfile = '/my-profile';
  static const statistics = '/statistics';
  static const settings = '/settings';
  static const notifications = '/notifications';
  static const security = '/security';
  static const help = '/help';
  static const about = '/about';
  static const location = '/location';
  static const notification = '/notification';
  static const language = '/language';
  

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
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: verifyEmail,
      page: () => const VerifyEmailScreen(),
      binding: VerifyEmailBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: verifySuccess,
      page: () => const VerifySuccessScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: taskDetail,
      page: () => const TaskDetailScreen(),
      binding: TaskDetailBinding(),
    ),
    GetPage(
      name: addTask,
      page: () => const AddTaskScreen(),
      binding: AddTaskBinding(),
    ),
    GetPage(
      name: calendar,
      page: () => const CalendarScreen(),
      binding: CalendarBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: editTask,
      page: () => const EditTaskScreen(),
      binding: EditTaskBinding(),
    ),
    GetPage(
      name: profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: myProfile,
      page: () => const MyProfileScreen(),
      binding: MyProfileBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: statistics,
      page: () => const StatisticScreen(),
      binding: StatisticBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: settings,
      page: () => const SettingsScreen(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: location,
      page: () => const LocationScreen(),
      binding: LocationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: notifications,
      page: () => const NotificationScreen(),
      binding: NotificationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: security,
      page: () => const SecurityScreen(),
      binding: SecurityBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: notification,
      page: () => const NotificationScreen(),
      binding: NotificationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: language,
      page: () => const LanguageScreen(),
      binding: LanguageBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
