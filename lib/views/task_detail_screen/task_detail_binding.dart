import 'package:get/get.dart';
import '../../controllers/task_detail_controller.dart';

class TaskDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskDetailController>(() => TaskDetailController());
  }
} 