import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/sms_console_controller.dart';

class CostBreakdownCard extends GetView<SmsConsoleController> {
  const CostBreakdownCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Obx(() {
          if (controller.costBreakdownError.value != null) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                SizedBox(height: 16.h),
                Text(
                  'Failed to load cost breakdown',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                  onPressed: controller.fetchCostBreakdown,
                  child: const Text('Retry'),
                ),
              ],
            );
          }

          final data = controller.costBreakdown.value;
          if (data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cost Breakdown',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    '${data.currency} ${data.totalCost}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ],
              ),
              const Divider(height: 24),
              ...data.rows.map((row) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              row.provider,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${row.messageCount} messages',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Text(
                          '${data.currency} ${row.totalCost}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )),
            ],
          );
        }),
      ),
    );
  }
}
