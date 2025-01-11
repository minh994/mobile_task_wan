import 'package:flutter/material.dart';
import '../../core/base/base_view.dart';
import '../../controllers/verify_account_controller.dart';
import 'package:get/get.dart';

class VerifyAccountScreen extends BaseView<VerifyAccountController> {
  const VerifyAccountScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Image.asset(
                'assets/verification.png',
                height: 200,
              ),
              const SizedBox(height: 32),
              Text(
                'Verify email'.tr,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'We have sent a verification email to\n${controller.email}'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              _buildResendButton(),
              const Spacer(),
              _buildVerifyButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResendButton() {
    return Obx(() {
      if (controller.canResend.value) {
        return TextButton(
          onPressed: controller.resendVerificationEmail,
          child: Text('Resend verification email'.tr),
        );
      }
      return Text(
        'Resend after ${controller.resendCountdown.value} seconds'.tr,
        style: const TextStyle(color: Colors.grey),
      );
    });
  }

  Widget _buildVerifyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.checkEmailVerification,
        child: Text('I have verified my email'.tr),
      ),
    );
  }
}
