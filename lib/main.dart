import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:mobile_app/core/constants/app_colors.dart';
import 'package:mobile_app/firebase_options.dart';
import 'package:mobile_app/core/bindings/initial_binding.dart';
import 'core/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Management',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.white,
      ),
      initialBinding: InitialBinding(),
      initialRoute: AppRouter.defaultRoute,
      getPages: AppRouter.routes,
      defaultTransition: Transition.fade,
    );
  }
}
