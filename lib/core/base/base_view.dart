import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_controller.dart';

abstract class BaseView<T extends BaseController> extends GetView<T> {
  const BaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildView(context),
        Obx(() => controller.isLoading
            ? Container(
                color: Colors.black26,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : const SizedBox()),
      ],
    );
  }

  Widget buildView(BuildContext context);
}
