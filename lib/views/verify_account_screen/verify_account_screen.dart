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
                'Xác thực email',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Chúng tôi đã gửi email xác thực đến\n${controller.email}',
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
          child: const Text('Gửi lại email xác thực'),
        );
      }
      return Text(
        'Gửi lại sau ${controller.resendCountdown.value} giây',
        style: const TextStyle(color: Colors.grey),
      );
    });
  }

  Widget _buildVerifyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.checkEmailVerification,
        child: const Text('Tôi đã xác thực email'),
      ),
    );
  }
}
