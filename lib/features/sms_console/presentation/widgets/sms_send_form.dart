import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../controllers/sms_console_controller.dart';

import '../../../../core/utils/validators/app_validators.dart';

class SmsSendForm extends GetView<SmsConsoleController> {
  const SmsSendForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Send SMS',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16.h),
              AppTextField(
                controller: controller.phoneController,
                label: 'Recipient Phone',
                hintText: '+4915112345678',
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone),
                validator: AppValidators.validatePhoneNumber,
              ),
              SizedBox(height: 12.h),
              AppTextField(
                controller: controller.bodyController,
                label: 'Message Body',
                hintText: 'Your code is 123456',
                maxLines: 3,
                prefixIcon: const Icon(Icons.message),
                validator: (value) => AppValidators.validateEmptyText(value, 'Message body'),
              ),
              SizedBox(height: 20.h),
              Obx(
                () => AppButton(
                  text: 'Send Message',
                  isLoading: controller.isSending.value,
                  onPressed: controller.sendSms,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
