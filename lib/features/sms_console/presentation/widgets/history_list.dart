import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/sms_console_controller.dart';

class HistoryList extends GetView<SmsConsoleController> {
  final bool shrinkWrap;
  const HistoryList({super.key, this.shrinkWrap = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
          child: Text(
            'Message History',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        if (shrinkWrap)
          Obx(() => _buildListContent(context))
        else
          Expanded(
            child: Obx(() => _buildListContent(context)),
          ),
      ],
    );
  }

  Widget _buildListContent(BuildContext context) {
    if (controller.historyError.value != null && controller.historyItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            SizedBox(height: 16.h),
            const Text('Failed to load history'),
            TextButton(
              onPressed: () => controller.fetchHistory(refresh: true),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (controller.historyItems.isEmpty && controller.isHistoryLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.historyItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 48.sp, color: Colors.grey),
            SizedBox(height: 16.h),
            const Text('No messages sent yet'),
          ],
        ),
      );
    }

    final listView = ListView.builder(
      padding: EdgeInsets.only(bottom: 20.h),
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
      itemCount: controller.historyItems.length + (controller.nextCursor.value != null ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == controller.historyItems.length) {
          controller.fetchHistory();
          return const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ));
        }

        final item = controller.historyItems[index];
        return Card(
          margin: EdgeInsets.only(bottom: 8.h),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(item.status).withValues(alpha: 0.1),
              child: Icon(
                _getStatusIcon(item.status),
                color: _getStatusColor(item.status),
                size: 20.sp,
              ),
            ),
            title: Text(item.recipient),
            subtitle: Text(
              '${item.status} • ${DateFormat('MMM dd, HH:mm').format(item.sentAt)}',
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '€${item.cost}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${item.segmentCount} seg',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
    );

    if (shrinkWrap) return listView;

    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchHistory(refresh: true);
      },
      child: listView,
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'DELIVERED':
        return Colors.green;
      case 'SENT':
      case 'ACCEPTED':
        return Colors.blue;
      case 'FAILED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'DELIVERED':
        return Icons.done_all;
      case 'SENT':
      case 'ACCEPTED':
        return Icons.done;
      case 'FAILED':
        return Icons.error_outline;
      default:
        return Icons.hourglass_empty;
    }
  }
}
