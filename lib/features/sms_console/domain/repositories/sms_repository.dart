import '../entities/cost_breakdown_entity.dart';
import '../entities/sms_history_entity.dart';
import '../entities/sms_message_entity.dart';

abstract class SmsRepository {
  Future<SmsMessageEntity> sendSms({
    required String to,
    required String body,
    String? referenceId,
  });

  Future<CostBreakdownEntity> getCostBreakdown({
    DateTime? from,
    DateTime? to,
  });

  Future<(List<SmsHistoryItemEntity> items, String? nextCursor)> getMessageHistory({
    String? cursor,
    int limit = 50,
  });
}
