import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app/services/task_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/routes/app_router.dart';
import 'firebase_options.dart';
import 'core/translations/app_translations.dart';
import 'services/auth_service.dart';
import 'services/user_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Khởi tạo services
  Get.put<AuthService>(AuthService(), permanent: true);
  Get.put<UserService>(UserService(), permanent: true);
  Get.put<TaskService>(TaskService(), permanent: true);
  

  // Load saved language
  final prefs = await SharedPreferences.getInstance();
  final String languageCode = prefs.getString('language') ?? 'en';

  runApp(MyApp(languageCode: languageCode));
}

class MyApp extends StatelessWidget {
  final String languageCode;
  
  const MyApp({
    Key? key,
    required this.languageCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Management'.tr,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: AppRouter.defaultRoute,
      getPages: AppRouter.routes,
      translations: AppTranslations(),
      locale: Locale(languageCode),
      fallbackLocale: const Locale('en'),
    );
  }
}
