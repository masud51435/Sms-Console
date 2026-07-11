import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/sms_console_controller.dart';
import '../widgets/cost_breakdown_card.dart';
import '../widgets/history_list.dart';
import '../widgets/sms_send_form.dart';

class SmsConsoleScreen extends GetView<SmsConsoleController> {
  const SmsConsoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS Console'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshAll,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showTenantSettings,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return _buildDesktopLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return RefreshIndicator(
      onRefresh: controller.refreshAll,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              const SmsSendForm(),
              SizedBox(height: 16.h),
              const CostBreakdownCard(),
              SizedBox(height: 16.h),
              const HistoryList(shrinkWrap: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side - Forms and Stats
          SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SmsSendForm(),
                  const SizedBox(height: 24),
                  const CostBreakdownCard(),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),
          // Right Side - History
          const Expanded(
            child: HistoryList(),
          ),
        ],
      ),
    );
  }

  void _showTenantSettings() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tenant Configuration',
              style: Get.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.tenantController,
              decoration: const InputDecoration(
                labelText: 'Tenant ID (UUID)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                controller.switchTenant(controller.tenantController.text);
                Get.back();
              },
              child: const Text('Apply & Refresh'),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
