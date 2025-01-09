import 'package:get/get.dart';
import '../core/base/base_controller.dart';
import '../core/routes/app_router.dart';

class SettingsController extends BaseController {
  void goToNotifications() {
    Get.toNamed(AppRouter.notifications);
  }

  void goToSecurity() {
    Get.toNamed(AppRouter.security);
  }

  void goToHelp() {
    Get.toNamed(AppRouter.help);
  }

  void checkForUpdates() {
    showMessage('Checking for updates...');
    // TODO: Implement update check
  }

  void goToAbout() {
    Get.toNamed(AppRouter.about);
  }

  void inviteFriend() {
    // TODO: Implement share functionality
    showMessage('Share feature coming soon!');
  }
} 