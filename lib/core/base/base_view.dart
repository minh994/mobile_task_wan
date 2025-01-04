import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_controller.dart';

abstract class BaseView<T extends BaseController> extends GetView<T> {
  const BaseView({super.key});

  // Widget hiển thị khi loading
  Widget get loadingWidget => const Center(
        child: CircularProgressIndicator(),
      );

  // Widget hiển thị khi có lỗi
  Widget errorWidget(String message) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => onRetry(),
              child: const Text('Thử lại'),
            ),
          ],
        ),
      );

  // Widget chính của màn hình
  Widget buildView(BuildContext context);

  // Hàm retry khi có lỗi
  void onRetry() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading) {
          return loadingWidget;
        }

        if (controller.errorMessage.isNotEmpty) {
          return errorWidget(controller.errorMessage);
        }

        return buildView(context);
      }),
    );
  }
}
