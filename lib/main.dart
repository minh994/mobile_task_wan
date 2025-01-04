import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/firebase_options.dart';
import 'package:mobile_app/services/auth_service.dart';
import 'package:mobile_app/services/task_service.dart';
import 'package:mobile_app/services/user_service.dart';
import 'core/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      Get.put(UserService());
      Get.put(AuthService());
      Get.put(TaskService());
      // Run app!
      runApp(const MyApp());
    },
    (error, stackTrace) {},
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      getPages: AppRouter.routes,
      defaultTransition: Transition.fade,
    );
  }
}
