import 'package:get/get.dart';
import '../core/base/base_controller.dart';
import '../services/task_service.dart';
import '../services/auth_service.dart';
import 'package:intl/intl.dart';

class StatisticController extends BaseController {
  final _taskService = Get.find<TaskService>();
  final _authService = Get.find<AuthService>();

  final selectedYear = DateTime.now().year.obs;
  final monthlyProgress = <int, double>{}.obs;
  final totalTasks = 846.obs;
  final completedTasks = 682.obs;


  @override
  void onInit() {
    super.onInit();
    loadStatistics();
  }

  Future<void> loadStatistics() async {
    try {
      showLoading();
      final userId = _authService.currentUser.value?.uid;
      if (userId != null) {
        // Load statistics for each month
        for (int month = 1; month <= 12; month++) {
          final progress = await _calculateMonthProgress(month);
          monthlyProgress[month] = progress;
        }
      }
      hideLoading();
    } catch (e) {
      hideLoading();
      showError('Error loading statistics: $e'.tr);
    }
  }

  Future<double> _calculateMonthProgress(int month) async {
    // Mô phỏng dữ liệu - thay thế bằng dữ liệu thực từ backend
    switch (month) {
      case 1:
        return 0.75;
      case 2:
        return 0.90;
      case 3:
        return 0.86;
      case 4:
        return 0.50;
      case 5:
        return 0.68;
      case 6:
        return 0.80;
      case 7:
        return 0.70;
      case 8:
        return 0.85;
      default:
        return 0.0;
    }
  }

  void previousYear() {
    selectedYear.value--;
    loadStatistics();
  }

  void nextYear() {
    if (selectedYear.value < DateTime.now().year) {
      selectedYear.value++;
      loadStatistics();
    }
  }

  double getMonthProgress(int month) {
    return monthlyProgress[month] ?? 0.0;
  }

  String getMonthName(int month) {
    return DateFormat('MMMM').format(DateTime(2024, month)).tr;
  }
} 