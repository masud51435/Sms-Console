import 'package:intl/intl.dart';

class AppFormatter {
  static String formatDate(String dateStr) {
    if (dateStr.isEmpty) return '';
    try {
      DateTime date = DateTime.parse(dateStr).toLocal();
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  static String formatTime(String dateStr) {
    if (dateStr.isEmpty) return '';
    try {
      DateTime date = DateTime.parse(dateStr).toLocal();
      return DateFormat('h:mm a').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  static String formatLastSync(DateTime? dateTime) {
    if (dateTime == null) return 'Never synced';

    final now = DateTime.now();
    final localDateTime = dateTime.toLocal();
    final difference = now.difference(localDateTime);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inHours < 1) return '${difference.inMinutes}m ago';

    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'Today, ${DateFormat('h:mm a').format(localDateTime)}';
    }

    return DateFormat('MMM d, h:mm a').format(localDateTime);
  }
}
