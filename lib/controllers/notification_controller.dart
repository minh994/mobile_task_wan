import 'package:get/get.dart';
import '../core/base/base_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends BaseController {
  final notificationTone = 'Silent'.obs;
  final vibrate = false.obs;
  final popupNotification = true.obs;
  final highPriorityNotification = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    notificationTone.value = prefs.getString('notification_tone') ?? 'Silent'.tr;
    vibrate.value = prefs.getBool('vibrate') ?? false;
    popupNotification.value = prefs.getBool('popup_notification') ?? true;
    highPriorityNotification.value = prefs.getBool('high_priority_notification') ?? false;
  }

  Future<void> toggleHighPriorityNotification(bool value) async {
    highPriorityNotification.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('high_priority_notification', value);
  }
} 