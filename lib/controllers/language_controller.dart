import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../core/base/base_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends BaseController {
  final currentLanguage = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    currentLanguage.value = prefs.getString('language') ?? 'en';
  }

  Future<void> changeLanguage(String languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language', languageCode);
      currentLanguage.value = languageCode;
      
      var locale = Locale(languageCode);
      Get.updateLocale(locale);
      
      showSuccess('language_changed'.tr);
    } catch (e) {
      showError('language_error'.tr);
    }
  }
} 