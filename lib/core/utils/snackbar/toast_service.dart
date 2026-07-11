import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';

class ToastService {
  static void showSuccess(String message, {Color? bgColor}) {
    _showToast(
      message: message,
      icon: Icons.check_circle,
      bgColor: bgColor ?? AppColors.primary,
    );
  }

  static void showError(String message) {
    _showToast(message: message, icon: Icons.error, bgColor: AppColors.error);
  }

  static void _showToast({
    required String message,
    required IconData icon,
    required Color bgColor,
  }) {
    Get.snackbar(
      '',
      '',
      titleText: const SizedBox.shrink(),
      messageText: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: bgColor,
      margin: EdgeInsets.all(16.w),
      borderRadius: 12.w,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
