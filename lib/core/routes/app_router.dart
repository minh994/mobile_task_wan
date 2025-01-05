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
    ),
    GetPage(
      name: '/edit-task',
      page: () => const EditTaskScreen(),
      binding: EditTaskBinding(),
    ),
    GetPage(
      name: '/profile',
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
  ];
}
